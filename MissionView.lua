local _, T = ...
local EV, L, U = T.Evie, T.L, T.Util

local FollowerList, MissionRewards

local function GenBoardMask()
	local m, MP = 0, CovenantMissionFrame.MissionTab.MissionPage
	for i=0,12 do
		local f = MP.Board.framesByBoardIndex[i]
		if f and f.name and f:IsShown() then
			m = m + 2^i
		end
	end
	return m
end
local function GetIncomingAAMask(slot, bm)
	local r, TP = 0, T.VSim.TP
	local f = CovenantMissionFrame.MissionTab.MissionPage.Board.framesByBoardIndex
	local mid = CovenantMissionFrame.MissionTab.MissionPage.missionInfo.missionID

	local board = U.GetMaskBoard(bm)
	if slot < 5 then
		for _,v in pairs(C_Garrison.GetMissionDeploymentInfo(mid).enemies) do
			local i = v.boardIndex
			local fi = f[i]
			local s1 = fi.autoCombatSpells and fi.autoCombatSpells[1]
			local aa = T.KnownSpells[TP:GetAutoAttack(v.role, i, mid, s1 and s1.autoCombatSpellID)]
			if aa and TP.GetTargets(i, aa.target, board)[1] == slot then
				r = bit.bor(r, 2^i)
			end
		end
	else
		for i=0, 4 do
			if bm % 2^(i+1) >= 2^i then
				local fi = f[i]
				local v, s1 = fi.info, fi.autoCombatSpells and fi.autoCombatSpells[1]
				local aa = T.KnownSpells[T.VSim.TP:GetAutoAttack(v.role, nil, nil, s1 and s1.autoCombatSpellID)]
				if aa and TP.GetTargets(i, aa.target, board)[1] == slot then
					r = bit.bor(r, 2^i)
				end
			end
		end
	end

	return r
end
local function Puck_OnEnter(self)
	if not self.name then
		if GameTooltip:IsOwned(self) then
			GameTooltip:Hide()
		end
		return
	end
	local mid = CovenantMissionFrame.MissionTab.MissionPage.missionInfo.missionID
	local bi, bm = self.boardIndex, GenBoardMask()
	local info = self.info
	local acs = self.autoCombatantStats or self.info and self.info.autoCombatantStats
	if bi > 4 then
		for _,v in pairs(C_Garrison.GetMissionDeploymentInfo(mid).enemies) do
			if v.boardIndex == bi then
				info, acs = v, {currentHealth=v.health, maxHealth=v.maxHealth, attack=v.attack}
				break
			end
		end
	end
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	U.SetFollowerInfo(GameTooltip, info, self.autoCombatSpells, acs, mid, bi, bm, false)
	local aa = GetIncomingAAMask(bi, bm)
	if aa and aa > 0 then
		local nc = NORMAL_FONT_COLOR
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(L"Incoming attacks:" .. " " .. U.FormatTargetBlips(aa, bm, nil, "240:60:0", false), nc.r, nc.g, nc.b)
	end
	GameTooltip:Show()
	self:GetBoard():ShowHealthValues()
end
local function Puck_OnLeave(self)
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide()
	end
	self:GetBoard():HideHealthValues()
end
local function EnvironmentEffect_OnEnter(self)
	local info = self.info
	if not info then return end
	local sid = info.autoCombatSpellID
	local pfx = T.KnownSpells[sid] and "" or "|TInterface/EncounterJournal/UI-EJ-WarningTextIcon:0|t "
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT", -8, 0)
	GameTooltip:ClearLines()
	GameTooltip:AddDoubleLine(pfx .. "|T" .. info.icon .. ":0:0:0:0:64:64:4:60:4:60|t " .. info.name, "|cffa8a8a8" .. (L"[CD: %dT]"):format(info.cooldown) .. "|r")
	local guideLine = U.GetAbilityGuide(sid, -1, GenBoardMask(), false)
	local od = U.GetAbilityDescriptionOverride(info and info.autoCombatSpellID)
	local dc = od and 0.60 or 0.95
	GameTooltip:AddLine(info.description, dc, dc, dc, 1)
	if od then
		GameTooltip:AddLine(od, 0.45, 1, 0, 1)
	end
	if guideLine then
		GameTooltip:AddLine(guideLine, 0.45, 1, 0, 1)
	end
	GameTooltip:Show()
end
local function EnvironmentEffect_OnLeave(self)
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide()
	end
end
local function EnvironmentEffect_OnNameUpdate(self_name)
	local ee = self_name:GetParent()
	ee:SetHitRectInsets(0, min(-100, -self_name:GetStringWidth()), 0, 0)
end
local GetSim do
	local simArch, simTag, simHadMS
	local deadline, rendCooldown, rendCallback, rendOwner
	function EV:GARRISON_MISSION_NPC_CLOSED()
		if rendOwner then
			rendOwner:SetScript("OnUpdate", nil)
		end
		simArch, simTag, rendCallback, rendOwner = nil
	end
	local function GetGroupTags()
		local f = CovenantMissionFrame.MissionTab.MissionPage.Board.framesByBoardIndex
		local mi  = CovenantMissionFrame.MissionTab.MissionPage.missionInfo
		local tag, htag = (mi.missionID) .. ":" .. (mi.missionScalar or 0), ""
		for i=0,4 do
			local ii = f[i].info
			if ii then
				local stats = ii.autoCombatantStats
				tag = tag .. ":" .. i .. ":" .. stats.attack .. ":" .. ii.followerID
				htag = htag .. ":" .. stats.currentHealth
			end
		end
		htag = tag .. htag
		return htag, tag
	end
	local function GetGroupData()
		local team, f = {}, CovenantMissionFrame.MissionTab.MissionPage.Board.framesByBoardIndex
		for i=0,4 do
			local ii = f[i].info
			if ii then
				team[#team+1] = {boardIndex=i, role=ii.role, stats=ii.autoCombatantStats, spells=f[i].autoCombatSpells}
			end
		end
		return team
	end
	local function qdeadline()
		return debugprofilestop() > deadline
	end
	local function OnUpdate(self)
		if not simArch or not GameTooltip:IsOwned(rendOwner) then
			self:SetScript("OnUpdate", nil)
			return
		end
		deadline = debugprofilestop() + 12
		simArch:Run(qdeadline)
		local res = simArch.res
		rendCooldown = (rendCooldown or 8) - 1
		if res and (res.isFinished or (res.hadWins and res.hadLosses)) then
			simArch.outOfDateHealth = GetGroupTags() ~= simTag
			rendCallback(rendOwner, simArch, simHadMS)
			self:SetScript("OnUpdate", nil)
			rendOwner, rendCallback, rendCooldown = nil
		elseif rendCooldown <= 0 then
			rendCallback(rendOwner, simArch, simHadMS)
			rendCooldown = nil
		end
	end
	function GetSim(owner, callback)
		local tag = GetGroupTags()
		if tag ~= simTag then
			local team = GetGroupData()
			local mi  = CovenantMissionFrame.MissionTab.MissionPage.missionInfo
			local eei = C_Garrison.GetAutoMissionEnvironmentEffect(mi.missionID)
			local mdi = C_Garrison.GetMissionDeploymentInfo(mi.missionID)
			local espell, ms = eei and eei.autoCombatSpellInfo
			simTag, simArch, ms = tag, T.VSim:New(team, mdi.enemies, espell, mi.missionID, mi.missionScalar)
			simHadMS, simArch.dropForks = ms and next(ms) and true or nil, true
			deadline = debugprofilestop() + 40
			simArch:Run(qdeadline)
		end
		local res = simArch and simArch.res
		local onUp = res and not res.isFinished and not (res.hadWins and res.hadLosses) and OnUpdate or nil
		owner:SetScript("OnUpdate", onUp)
		rendOwner, rendCallback, rendCooldown = onUp and owner, onUp and callback, nil
		if callback then
			callback(owner, simArch, simHadMS)
		end
		return simArch
	end
end
local function Predictor_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
	GameTooltip:SetText(ITEM_QUALITY_COLORS[5].hex .. L"Cursed Adventurer's Guide")
	GameTooltip:AddLine(ITEM_UNIQUE, 1,1,1, 1)
	GameTooltip:AddLine(L"Use: Read the guide, determining the fate of your adventuring party.", 0, 1, 0, 1)
	GameTooltip:AddLine(L'"Do not believe its lies! Balance druids are not emergency rations."', 1, 0.835, 0.09, 1)
	GameTooltip:Show()
end
local function Predictor_ShowResult(self, sim, incompleteModel)
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
	local res = sim.res
	local rngModel = res.hadDrops or (res.hadWins and res.hadLosses)
	local inProgress = not res.isFinished and not rngModel
	local hprefix = (incompleteModel and "|TInterface/EncounterJournal/UI-EJ-WarningTextIcon:0|t " or "")
	if inProgress then
		hprefix = hprefix .. "|cffff3300" .. L"Preliminary:" .. "|r "
	end
	if rngModel then
		GameTooltip:SetText(hprefix .. L"Curse of Uncertainty", 1, 0.20, 0)
	else
		GameTooltip:SetText(hprefix .. (sim.won and L"Victorious" or L"Defeated"), 1,1,1)
	end

	if incompleteModel then
		GameTooltip:AddLine(L"Not all abilities have been taken into account.", 0.9,0.25,0.15)
	end
	if inProgress then
		GameTooltip:AddLine(L"Not all outcomes have been examined.", 0.9, 0.25, 0.15, 1)
	end
	if sim.outOfDateHealth then
		GameTooltip:AddLine(L"Companion health has changed.", 0.9, 0.25, 0.15, 1)
	end
	if incompleteModel or inProgress or sim.outOfDateHealth then
		GameTooltip:AddLine(" ")
	end

	if rngModel then
		GameTooltip:AddLine(L"The guide shows you a number of possible futures. In some, the adventure ends in triumph; in others, a particularly horrible failure.", 1,1,1,1)
		if not incompleteModel then
			GameTooltip:AddLine(L'"With your luck, there is only one way this ends."', 1, 0.835, 0.09, 1)
		end
	else
		local lo, hi, c = res.min, res.max, NORMAL_FONT_COLOR
		local turns = lo[17] ~= hi[17] and lo[17] .. " - " .. hi[17] or lo[17]
		if turns then
			GameTooltip:AddLine((sim.won and L"Turns taken: %s" or L"Turns survived: %s"):format("|cffffffff" .. turns .. "|r"), c.r, c.g, c.b)
		end
		if sim.won then
			local troopCount, troopHealth1, troopHealth2, troopHealthMax = 0, 0, 0, 0
			local rewardXP = MissionRewards.xpGain or 0
			for i=0,4 do
				local hmin, hmax = lo[i], hi[i]
				local f = CovenantMissionFrame.MissionTab.MissionPage.Board.framesByBoardIndex[i]
				local e = sim.board[i]
				if f and f.name and f:IsShown() and f.info and hmin and e then
					local fi = f.info
					if fi.isAutoTroop then
						troopCount, troopHealth1, troopHealth2, troopHealthMax = troopCount + 1, troopHealth1 + hmin, troopHealth2 + hmax, troopHealthMax + (e.maxHP or 0)
					else
						local chp = hmin == hmax and hmin or ((hmin == 0 and "|cffff40200|r" or hmin) .. " |cffffffff-|r " .. hmax)
						local isUp = fi.xp and fi.levelXP and not fi.isMaxLevel and (fi.xp + rewardXP) >= fi.levelXP and "|A:bags-greenarrow:0:0|a" or ""
						GameTooltip:AddDoubleLine(f.name .. isUp, chp .. "/" .. e.maxHP, 1,1,1, hmax > 0 and 0 or 1, hmax > 0 and 1 or 0.3, 0.15)
					end
				end
			end
			if troopCount > 0 then
				local hmin, hmax = troopHealth1, troopHealth2
				local chp = hmin == hmax and hmin or ((hmin == 0 and "|cffff40200|r" or hmin) .. " |cffffffff-|r " .. hmax)
				GameTooltip:AddDoubleLine(FOLLOWERLIST_LABEL_TROOPS, chp .. "/" .. troopHealthMax, 1,1,1, troopHealth2 > 0 and 0 or 1, troopHealth2 > 0 and 1 or 0.3, 0.15)
			end
		else
			local hmin, hmax, maxHP = lo[15], hi[15], 0
			for i=5,12 do
				local e = sim.board[i]
				maxHP = maxHP + (e and e.maxHP or 0)
			end
			local chp = hmin == hmax and hmin or (hmin .. " - " .. hmax)
			hmin, hmax = math.ceil(hmin/maxHP*100), math.ceil(hmax/maxHP*100)
			local cr = hmin == hmax and hmin or (hmin .. "% - " .. hmax)
			GameTooltip:AddLine((L"Remaining enemy health: %s"):format("|cffffffff" .. chp .. " (" .. cr .. "%)|r"), c.r, c.g, c.b)
		end
		if not incompleteModel then
			if not sim.won then
				GameTooltip:AddLine(" ")
			end
			GameTooltip:AddLine(inProgress and (L'"%s possible futures and counting..."'):format(BreakUpLargeNumbers(res.n or 0)) or L'"Was there ever any doubt?"', 1, 0.835, 0.09)
		end
	end
	GameTooltip:Show()
end
local function Predictor_OnClick(self)
	GetSim(self, Predictor_ShowResult)
end
local function Predictor_OnLeave(self)
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide()
	end
end
local function MissionGroup_OnUpdate()
	local o = GameTooltip:IsVisible() and GameTooltip:GetOwner() or GetMouseFocus()
	if o and not o:IsForbidden() and o:GetScript("OnEnter") and o:GetParent():GetParent() == CovenantMissionFrame.MissionTab.MissionPage.Board then
		o:GetScript("OnEnter")(o)
	end
	FollowerList:SyncToBoard()
end
local function MissionRewards_OnShow(self)
	local mi = CovenantMissionFrame.MissionTab.MissionPage.missionInfo
	local d = mi and mi.duration
	self.Rewards:SetRewards(mi and mi.xp, mi and mi.rewards)
	self.Duration:SetText(d and L"Duration:" .. " |cffffffff" .. d or "")
	local xp = mi and mi.xp or 0
	for i=1,mi and mi.rewards and #mi.rewards or 0 do
		local r = mi.rewards[i]
		if r.followerXP then
			xp = xp + r.followerXP
		end
	end
	self.xpGain = xp
	if FollowerList then
		FollowerList:SyncXPGain(xp)
	end
end
local function MissionView_OnShow()
	if not FollowerList then
		FollowerList = T.CreateObject("FollowerList", CovenantMissionFrame)
		FollowerList:ClearAllPoints()
		FollowerList:SetPoint("BOTTOM", CovenantMissionFrameFollowers, "BOTTOM", 0, 8)
	end
	FollowerList:Refresh(MissionRewards and MissionRewards.xpGain)
	FollowerList:Show()
	CovenantMissionFrameFollowers:Hide()
	CovenantMissionFrameFollowers.MaterialFrame:SetParent(FollowerList)
	CovenantMissionFrameFollowers.HealAllButton:SetParent(FollowerList)
end
local function MissionView_OnHide()
	if FollowerList then
		FollowerList:Hide()
	end
	CovenantMissionFrameFollowers:Show()
	CovenantMissionFrameFollowers.MaterialFrame:SetParent(CovenantMissionFrameFollowers)
	CovenantMissionFrameFollowers.HealAllButton:SetParent(CovenantMissionFrameFollowers)
end
local function Mission_StoreTentativeGroup()
	local g, hc = {}, false
	local mid = CovenantMissionFrame.MissionTab.MissionPage.missionInfo.missionID
	local f = CovenantMissionFrame.MissionTab.MissionPage.Board.framesByBoardIndex
	for i=0,5 do
		local fi = f[i]
		if fi and fi.name and fi.info and fi:IsShown() then
			g[i], hc = fi.info.followerID, hc or not fi.info.isAutoTroop
		end
	end
	if hc then
		U.StoreMissionGroup(mid, g, true)
	end
end

function EV:I_ADVENTURES_UI_LOADED()
	local MP = CovenantMissionFrame.MissionTab.MissionPage
	for i=0,12 do
		local f = MP.Board.framesByBoardIndex[i]
		f:SetScript("OnEnter", Puck_OnEnter)
		f:SetScript("OnLeave", Puck_OnLeave)
		for i=1,2 do
			f.AbilityButtons[i]:EnableMouse(false)
			f.AbilityButtons[i]:SetMouseMotionEnabled(false)
		end
	end
	MP.CloseButton:SetScript("OnKeyDown", function(self, key)
		self:SetPropagateKeyboardInput(key ~= "ESCAPE")
		if key == "ESCAPE" then
			self:Click()
		end
	end)
	local mb = CreateFrame("Button", nil, MP.Board)
	mb:SetSize(64,64)
	mb:SetPoint("BOTTOMLEFT", 24, 8)
	mb:SetNormalTexture("Interface/Icons/INV_Misc_Book_01")
	mb:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
	mb:GetHighlightTexture():SetBlendMode("ADD")
	mb:SetPushedTexture("Interface/Buttons/UI-Quickslot-Depress")
	mb:GetPushedTexture():SetDrawLayer("OVERLAY")
	local t = mb:CreateTexture(nil, "ARTWORK")
	t:SetAllPoints()
	t:SetTexture("Interface/Icons/INV_Misc_Book_01")
	mb:SetScript("OnEnter", Predictor_OnEnter)
	mb:SetScript("OnLeave", Predictor_OnLeave)
	mb:SetScript("OnClick", Predictor_OnClick)
	MP.Stage.EnvironmentEffectFrame:SetScript("OnEnter", EnvironmentEffect_OnEnter)
	MP.Stage.EnvironmentEffectFrame:SetScript("OnLeave", EnvironmentEffect_OnLeave)
	hooksecurefunc(MP.Stage.EnvironmentEffectFrame.Name, "SetText", EnvironmentEffect_OnNameUpdate)
	hooksecurefunc(CovenantMissionFrame, "AssignFollowerToMission", MissionGroup_OnUpdate)
	hooksecurefunc(CovenantMissionFrame, "RemoveFollowerFromMission", MissionGroup_OnUpdate)
	MP.CloseButton:HookScript("PreClick", Mission_StoreTentativeGroup)
	local s = CovenantMissionFrame.MissionTab.MissionPage.Stage
	s.Title:SetPoint("LEFT", s.Header, "LEFT", 100, 9)
	local ir = T.CreateObject("InlineRewardBlock", s)
	MissionRewards = ir
	ir:SetPoint("LEFT", s.Header, "LEFT", 100, -16)
	ir.Duration = ir:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	ir.Duration:SetPoint("LEFT", ir, "RIGHT", 4, 0)
	hooksecurefunc(CovenantMissionFrame, "SetTitle", function()
		MissionRewards_OnShow(ir)
	end)
	hooksecurefunc(CovenantMissionFrame:GetMissionPage(), "Show", MissionView_OnShow)
	MP.Board:HookScript("OnHide", MissionView_OnHide)
	MP.Board:HookScript("OnShow", MissionView_OnShow)
	hooksecurefunc(CovenantMissionFrameFollowers, "UpdateFollowers", function()
		if MP.Board:IsVisible() and not (T.MissionList and T.MissionList:IsVisible()) then
			MissionView_OnShow()
		end
	end)
	MP.Stage.Title:SetWidth(320)
	return false
end