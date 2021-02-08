local _, T = ...
-- See https://www.townlong-yak.com/addons/venture-plan/localization

local C, z, V, K = GetLocale(), nil
V =
    C == "deDE" and { -- 52/52 (100%)
      "\"Glaub nicht seinen Lügen! Gleichgewichtsdruiden sind keine Notrationen.\"", "\"Gab es jemals Zweifel?\"", "\"Mit deinem Glück gibt es nur einen Weg, wie dies endet.\"", "(Nahkampf)", "(Fernkampf)", "1. Besuch:", "2. Kopiere den folgenden Text:", "Eine detaillierte Aufzeichnung eines Abenteuers, das deine Begleiter absolviert haben.", "Abenteuer läuft ab in:", "Abenteuerbericht",
      "Wird auch vergeben, wenn die Abenteurer besiegt wurden.", "Zum abschließen hier klicken", "Fluch der Unsicherheit", "Verfluchter Abenteurerführer", "Besiegt", "Zum Scheitern verurteilter Lauf", "Doppelklick: Sende diese Neulinge in den Untergang:", "Dauer:", "In jeder zweiten Runde wird ein zufälliger Feind für {}% seiner maximalen Gesundheit angegriffen.", "Wenn diese Mission fehlschlägt, erhält jeder Begleiter %s.",
      "Wird das erste Mal in Runde %d gewirkt.", "Gefährten XP", "Reduziert für zwei Runden den durch eingehende Angriffe verursachten Schaden um 1 und rächt sich für {}.", "Für das, was es wert ist, alles, woran du dich erinnerst, endete schlecht.", "Für das, was es wert ist, alles, woran du dich erinnerst, endete gut.", "Leben ist in %s wiederhergestellt", "Eingehende Angriffe:", "Fügt einem zufälligen Feind {} Schaden zu.", "Fügt allen Gegnern in Reichweite {} Schaden zu.", "Es macht nichts.",
      "Nicht alle Fähigkeiten wurden berücksichtigt.", "Impulse:", "Menge: %s", "Reduziert den von einem zufälligen Verbündeten erlittenen Schaden um 50%. Für immer.", "Reduziert den vom am weitesten entfernten Feind verursachten Schaden 3 Runden lang um 1.", "Reduziert den vom nächsten Verbündeten erlittenen Schaden für zwei Runden um 5000%.", "Verbleibende feindliche Gesundheit: %s", "Abenteuerberichte zurücksetzen", "Belohnung:", "Abenteurer auswählen",
      "Ziele:", "Der verfluchte Abenteurerführer hungert. Nur die Geschichten über die Abenteuer deiner Gefährten, die bis ins kleinste Detail ermittelt werden, können ihn befriedigen.", "Der Leitfaden zeigt Dir eine Reihe möglicher Zukünfte. In einigen Fällen endet das Abenteuer mit einem Triumph. In anderen in einem besonders schrecklichen Misserfolg.", "Der Leitfaden zeigt Dir viele mögliche Zukünfte. Zu viele. Es ist unmöglich, daraus Schlussfolgerungen über die Chancen deiner Gruppe zu ziehen.", "Um deine Abenteuerberichte einzureichen,", "Runden überlebt: %s", "Erfasste Runden: %s", "Benutzen: Füttere den verfluchten Abenteurerführer.", "Benutzen: Lies die Anleitung und bestimme das Schicksal deiner Abenteuergruppe.", "Siegreich",
      "Gesucht: Abenteuerberichte", "[CD: %dR]",
    }
    or C == "esES" and { -- 52/52 (100%)
      "\"¡No creo que mientas! Los druidas equilibrio no son raciones de emergencia.\"", "\"¿Alguna vez hubieron dudas?\"", "\"Con tu suerte, sólo hay una forma de cómo acabe esto.\"", "(melé)", "(distancia)", "1. Visita:", "2. Copia el texto siguiente:", "Un historial detallado de una aventura completada por tus compañeros.", "La Aventura Acaba En:", "Informe de la Aventura",
      "Otorgado aunque los aventureros hayan sido derrotados.", "Click para completar", "Maldición de la Incertidumbre", "Guía del Aventurero Maldito", "Derrotado", "Misión Condenada", "Doble click: envia tus tropas a su muerte:", "Duración:", "Cada dos turnos, un enemigo aleatorio es atacado por {}% de su salud máxima.", "Fallar esta misión garantiza %s a cada compañero.",
      "Su primer lanzamiento es durante el turno %d.", "XP del compañero", "Durante dos turnos, reduce el daño realizado por los ataques entrantes en 1 y toma represalias por {}.", "Por lo que vale, todo lo que recuerdas acabó mal.", "Por lo que vale, todo lo que recuerdas acabó bien.", "Sanación completa en %s", "Ataques entrantes:", "Inflinge {} daño a un enemigo aleatorio.", "Inflinge {} daño a todos los enemigos a distancia.", "No hace nada.",
      "No se tendrán en cuenta todas las habilidades.", "Pulsa:", "Cantidad: %s", "Reduce el daño recibido de un aliado aleatorio un 50%. Siempre.", "Reduce el daño recibido por el enemigo más lejano en 1 durante 3 rondas.", "Reduce el daño recibido del aliado más cercano un 5000% durante dos rondas.", "Salud enemiga restante: %s", "Resetear los Informes de Aventuras", "Recompensas:", "Selecciona aventureros",
      "Objetivos:", "La Guía del Aventurero Maldito tiene hambre. Sólo los relatos de las aventuras de tus compañeros, transmitidos con un detalle insoportable, la dejarán satisfecha.", "La guía muestra un número de posibles futuros. En unos, los aventureros acaban en triunfo; en otros, un fracaso particularmente horrible.", "La guía muestra varios futuros posibles. Demasiados. Es imposible sacar conclusiones sobre las posibilidades de tu grupo para esta aventura.", "Para enviar tus informes de aventuras,", "Turnos sobrevividos: %s", "Turnos usados: %s", "Usa: Alimenta la Guía del Aventurero Maldito", "Usa: Lee la guía, la cual determinará el destino de tu grupo de aventureros.", "Victorioso",
      "Se busca: Informes de Aventuras", "[CD: %dT]",
    }
    or C == "frFR" and { -- 51/52 (98%)
      "\"Ne croyez pas ses mensonges! Les druides équilibre ne sont pas des rations d'urgence.\"", "\"Y a-t-il déjà eu un doute?\"", "\"Avec votre chance, il n'y a qu'une seule façon que cela se termine.\"", "(corps à corps)", "(Distant)", "Visite:", "Copie du texte suivant:", "Enregistrement détaillé d'une aventure terminé par vos compagnons.", "l'aventure expire dans:", "Rapport d'aventure",
      "Décerné même si les aventuriers sont vaincus.", "Cliquer pour terminer", "Malédiction d'incertitude", "Guide de l'aventurier maudit", "Vaincu", "Course condamnée", "Double-cliquez: envoyez ces recrues vers leur destin:", "Durée:", "Un tour sur deux, un ennemi aléatoire est attaqué à raison de {}% de sa vie maximum.", "Échouer cette mission accorde %s à chaque compagnon.",
      "Premier sort pendant le tour %d.", "XP compagnion", "Pendant deux rounds, réduit les dégâts infligés par les attaques subies de 1 et riposte pour {}.", "Pour ce que cela vaut, tout ce dont vous vous souvenez s'est mal terminé.", "Pour ce que cela vaut, tout ce dont vous vous souvenez s'est bien terminé.", z, "Attaque en approche:", "Inflige {} dégâts à un ennemi aléatoire.", "Inflige {} de dégâts à tous les ennemis à portée.", "Ça ne fait rien.",
      "Toutes les capacités n'ont pas été prises en compte.", "Impulsion:", "Quantité: %s", "Réduit les dégâts infligés à un allié aléatoire de 50%. Pour toujours.", "Réduit les dégâts infligés par l'ennemi le plus éloigné de 1 pendant 3 rounds.", "Réduit les dégâts subis par l'allié le plus proche de 5000% pendant deux rounds.", "Vie restante des ennemis: %s", "Reset du rapport d'aventure", "Récompenses:", "Sélection des aventuriers",
      "Cible:", "Le guide de l'aventurier maudit a faim. Seuls les récits des aventures de vos compagnons, expliqués dans des détails atroces, le satisferont.", "Le guide vous montre un certain nombre de futurs possibles. Chez certains, l'aventure se termine par un triomphe; dans d'autres, un échec particulièrement horrible.", "Le guide vous montre de nombreux futurs possibles. Trop. Il est impossible d'en tirer des conclusions sur les chances de votre groupe.\r\n\r\n", "Pour soumettre vos rapports d'aventure,", "Tours survécu: %s", "Tours effectués: %s", "Utilise: Nourrissez le guide de l'aventurier maudit.", "Utilise: Lisez le guide pour déterminer le sort de votre groupe d'aventures.", "Victorieux",
      "Recherché: Rapports d'aventure", "[CD: %dT]",
    }
    or C == "itIT" and { -- 52/52 (100%)
      "\"Non fidarti delle sue menzogne! I druidi dell'equilibrio non sono razioni di emergenza.\"", "\"Ci sono mai stati dubbi?\"", "\"Con la tua fortuna, è il solo modo in cui questo finisce.\"", "(mischia)", "(a distanza)", "1. Visita:", "2. Copia il seguente testo:", "Un registro dettagliato di un'avventura completata dai tuoi avventurieri.", "Avventura in scadenza:", "Rapporto dell'Avventura",
      "Ottenuto anche se gli avventurieri vengono sconfitti.", "Clicca per completare", "Maledizione dell'incertezza", "Guida dell'Avventuriero Maledetto", "Sconfitta", "Avventura Spacciata", "Doppio clic: invia quei novellini alla loro rovina:", "Durata:", "Ogni altro turno, a un nemico casuale viene inflitto il {}% della sua salute massima.", "Fallire questa missione conferisce %s a ciascun avventuriero.",
      "Lanciato per la prima volta durante il turno %d.", "EXP per seguaci", "Per 2 turni, riduce di 1 il danno inflitto dagli attacchi in arrivo e si vendica di {}.", "Per quel che vale, tutto quello che ricordi è che è andata a finire male.", "Per quel che vale, tutto quello che ricordi è che è andata a finire bene.", "Recupero vitale completo in %s", "Attacchi in arrivo:", "Infligge {} danni a un nemico casuale.", "Infligge {} danni a tutti i nemici a portata.", "Non fa nulla.",
      "Non tutte le abilità sono state prese in considerazione.", "Impulso:", "Quantità: %s", "Riduce del 50% i danni subiti da un alleato casuale. Per sempre.", "Riduce di 1 il danno inflitto dal nemico più lontano per 3 turni.", "Riduce del 5000% i danni subiti dall'alleato più vicino per 2 turni.", "Salute nemica rimanente: %s", "Reimposta i rapporti dell'Avventura", "Ricompense:", "Seleziona avventurieri",
      "Bersagli:", "La Guida dell'Avventuriero Maledetto ha fame. Solo i racconti delle avventure dei tuoi compagni, trasmessi con dettagli atroci, lo soddisferanno.", "La guida mostra una serie di possibili futuri. In alcuni, l'avventura finisce in trionfo; in altri, un fallimento particolarmente orribile.", "La guida mostra molti possibili futuri. Troppi. È impossibile trarre conclusioni sulle possibilità del tuo gruppo da questo.", "Per inviare i tuoi rapporti dell'avventura,", "Turni sopravvissuti: %s", "Turni effettuati: %s", "Uso: Alimenta la Guida dell'Avventuriero Maledetto.", "Uso: Leggi la Guida, determinando il destino del tuo gruppo di avventurieri.", "Vittoria",
      "Cercasi: Rapporti dell'Avventura", "[CD: %d turni]",
    }
    or C == "koKR" and { -- 52/52 (100%)
      "\"거짓말을 믿지 마세요! 조화 드루이드는 비상식량이 아닙니다.\"", "\"의심의 여지가 있을까요?\"", "\"운이 좋다면, 이를 끝내는 방법은 오직 하나 뿐입니다.\"", "(근접)", "(원거리)", "1.방문하기:", "2.다음 문자열을 복사하세요:", "당신이 완료한 모험에 대한 세부 기록입니다.", "만료까지 남은 시간:", "모험 보고서",
      "모험이 실패해도 받는 보상입니다.", "완료하기", "불확실성의 저주", "저주받은 모험가의 안내서", "패배", "파멸의 임무", "더블 클릭: 아래 신참들을 파멸로 보냅니다.", "소요시간:", "두 턴에 한 번씩, 무작위 적군은 최대 체력의 {}% 만큼 피해를 입습니다.", "임무를 실패해서 동료마다 %s의 경험치를 먹입니다.",
      "첫번째 시전은 %d라운드 동안 유지됩니다", "동료 경험치", "2라운드 동안, 받는 피해를 1로 감소시키고 {}만큼 반격합니다.", "도움이 될지는 모르겠지만, 당신이 기억하는 모든 것은 나쁘게 끝났습니다.", "도움이 될지는 모르겠지만, 당신이 기억하는 모든 것은 잘 끝났습니다.", "%s 동안 체력 완전 회복", "공격 받음:", "무작위 적에게 {}의 피해를 입힙니다.", "범위 내의 모든 적에게 {}의 피해를 입힙니다.", "아무런 효과가 없습니다.",
      "계산에 포함되지 않은 능력이 있습니다.", "주기", "수량: %s", "무작위 아군의 받는 피해를 영구적으로 50% 만큼 감소시킵니다.", "가장 멀리 있는 적의 공격력을 3라운드 동안 1만큼 감소시킵니다.", "가장 가까운 아군이 받는 피해를 2라운드 동안 5000% 만큼 감소시킵니다.", "적의 남은 체력: %s", "모험 보고서 초기화", "보상:", "동료 선택",
      "대상:", "저주받은 모험가 안내서가 굶주려 있습니다. 당신의 모험담만이 그것을 만족시킬 것입니다.", "안내서가 여러가지 가능성을 보여줍니다. 그 중엔 승리하는 미래도 있고, 끔찍하게 실패하는 미래도 있습니다.", "안내서가 보여주는 가능성이 너무 많아, 이를 토대로 가능한 미래를 예측할 수 없습니다.", "모험 보고서를 전송하려면,", "%s 턴 동안 생존", "%s 턴 소요됨", "사용: 저주받은 모험가의 안내서에 먹이를 줍니다.", "사용: 안내서를 읽어, 모험을 떠날 동료들의 운명을 가늠합니다.", "승리",
      "수배중: 모험가 보고서", "[재사용: %d라운드]",
    }
    or C == "ruRU" and { -- 52/52 (100%)
      "\"Не верьте в эту ложь! Баланс друиды не являются сухпайком.\"", "\"Разве были какие-либо сомнения?\"", "\"С твоей удачей, существует лишь один исход\"", "(ближний бой)", "(дальний бой)", "1. Ссылка на сайт:", "2. Скопируйте следующий текст:", "Подробный отчет о приключениях ваших спутников.", "Приключение исчезнет через:", "Отчет о приключениях",
      "Получаемый опыт, даже если ваши спутники потерпят неудачу.", "Нажмите для завершения", "Проклятие Неопределенности", "Проклятое Руководство Искателя приключений", "Поражение", "Обреченный поход", "Двойной щелчок мыши: отправьте своих новобранцев навстречу судьбе:", "Длительность:", "Каждый ход случайному противнику наносится урон в размере {}% его максимального запаса здоровья.", "Неудачное завершение этого задания даст %s каждому спутнику.",
      "Первое произнесение заклинания в течении хода %d.", "Опыт спутника", "На два хода снижает входящий урон от атак на 1 ед. и контратакует на {}.", "Как бы то ни было - все, что вы помните, кончилось плохо.", "Как бы то ни было - все, что вы помните, кончилось хорошо.", "Полное восстановление через %s", "Входящие атаки:", "Наносит {} урона случайному противнику.", "Наносит {} урона всем противникам на расстоянии.", "Ничего не делает.",
      "Не все способности были приняты в расчет", "Пульсация:", "Количество: %s", "Снижает урон, получаемый случайным союзником, на 50% в течении боя.", "Снижает урон, наносимый самым дальним противником на 1 ед. в течении 3-х ходов.", "Снижает урон, получаемый ближайшим союзником на 5000% на 2 хода.", "Оставшееся здоровье противника: %s", "Удалить отчеты о приключениях", "Награды:", "Выберите спутников",
      "Цели:", "Проклятое Руководство Искателя Приключений жаждет знаний. Только рассказы о приключениях ваших спутников, переданные в мучительных подробностях, удовлетворят его.", "Руководство показывает вам возможные варианты исхода событий. В некоторых случаях приключение заканчивается победой, в других - ужасной неудачей.", "Руководство показывает вам возможные варианты исхода событий. Слишком много. Невозможно предугадать точный исход событий для ваших соратников.", "Чтобы подтвердить отчеты о приключениях,", "Ходов выжили: %s", "Ходов прошло: %s", "Использование: Утолить жажду знаний Проклятого Руководства Искателя Приключений.", "Использование: Прочитать руководство, которое определит судьбу ваших спутников.", "Победа",
      "Разыскивается: Отчеты о приключениях", "[Перезарядка: %dХод]",
    }
    or C == "zhCN" and { -- 52/52 (100%)
      "“不要相信谎言！平衡德不是救命稻草。”", "“有什么问题？”", "“走狗屎运的话可能会赢”", "（近战）", "（远程）", "1. 访问", "2. 复制下面的文字", "一份由你的伙伴完成的探险的详细记录", "探险过期时间：", "探险报告：",
      "即使探险失败也有奖励", "点击以完成", "结果不确定", "受诅咒的探险指南", "失败", "有去无回", "双击送这些菜鸟上路", "回合数：", "每隔一个回合，一个随机敌人会受到{}％最大生命值的攻击", "每个伙伴可从此失败的任务中获取%s的经验",
      "在第%d回合时先发", "追随者经验", "在接下来的两回合内减少受到的伤害并且还击{}", "总的来说，结果很惨", "总的来说，结果很棒", "完全恢复%s", "受到的攻击：", "对随机敌人造成{}的伤害", "对范围内的敌人造成{}伤害", "没什么效果",
      "没有考虑到所有的技能", "每跳：", "数量：%s", "永久减少50%来自随机盟友的伤害", "降低1点来自最远敌人的伤害，持续3回合", "使最近盟友受到的伤害降低5000%，持续2回合", "敌人剩余生命值：%s", "重置冒险报告", "奖励：", "选择冒险者",
      "目标：", "Cursed Adventurer's Guide已经饥渴难耐。只有来自你的冒险者的传奇故事才能满足它。", "指南会展示一系列可能的结果，既可能胜利，也会有可怕的失败。", "指南会展示许多可能的未来。未来如此多变，因而不可能呈现一个精确的结论。", "如要提交探险报告，", "存活回合数：%s", "需要的回合数：%s", "喂饱Cursed Adventurer's Guide.", "用法：阅读指南，决定你的冒险小队的命运。", "胜利",
      "通缉：探险报告", "[冷却: %d轮]",
    }
    or C == "zhTW" and { -- 51/52 (98%)
      "不要相信這個謊話！平衡德不是應急口糧。", "懷疑嗎？", "看你的運氣囉", "(近戰)", "(遠程)", "1. 訪問", "複製以下的文字：", "詳細戰鬥紀錄", "冒險過期時限", "冒險報告",
      "即使冒險失敗仍會獲得的獎勵", "點擊完成", "不確定性", "被咀咒的冒險者指南", "失敗", "送死回合", "雙擊：把菜鳥派去送頭：", "持續時間", "每一個回合，一個隨機敵人受到他們最大血量{}%的傷害。", "任務失敗使每個同伴獲得%s",
      "在%d回合第一次施放", "追隨者經驗值", "", "無論如何，你記得的所有事情都有壞結果。", "無論如何，你記得的所有事情都有好結果。", z, "即將到來的攻擊：", "對隨機敵人造成{}傷害", "對遠程的所有敵人造成 {}傷害", "無效",
      "部分能力未被計算。", "脈衝", "數量：%s", "永久減少隨機同伴的50%承受傷害。", "對距離最遠的敵人減傷1點持續三回合", "使最近的盟友減傷5000%，持續兩回合。", "敵方血量：%s", "重置冒險報告", "獎賞：", "選擇冒險",
      "目標：", "需要冒險報告以改善這個冒險指南", "本指南提供你幾個可能的結果。其中一些冒險會凱旋歸來；其他的則會是可怕的失敗。", "本指南有太多可能的結果。太多了。無法提供結論。", "提交你的冒險報告，", "存活回合：%s", "需要回合：%s", "使用：提供冒險經歷。", "使用：閱讀本指南，決定你的冒險隊伍的命運。", "勝利",
      "徵求：冒險報告", "[冷卻:%d 回合]",
    } or nil

K = V and {
      "\"Do not believe its lies! Balance druids are not emergency rations.\"", "\"Was there ever any doubt?\"", "\"With your luck, there is only one way this ends.\"", "(melee)", "(ranged)", "1. Visit:", "2. Copy the following text:", "A detailed record of an adventure completed by your companions.", "Adventure Expires In:", "Adventure Report",
      "Awarded even if the adventurers are defeated.", "Click to complete", "Curse of Uncertainty", "Cursed Adventurer's Guide", "Defeated", "Doomed Run", "Double click: send these rookies to their doom:", "Duration:", "Every other turn, a random enemy is attacked for {}% of their maximum health.", "Failing this mission grants %s to each companion.",
      "First cast during turn %d.", "Follower XP", "For two rounds, reduces the damage dealt by incoming attacks by 1 and retaliates for {}.", "For what it is worth, everything you remember ended badly.", "For what it is worth, everything you remember ended well.", "Full recovery in %s", "Incoming attacks:", "Inflicts {} damage to a random enemy.", "Inflicts {} damage to all enemies at range.", "It does nothing.",
      "Not all abilities have been taken into account.", "Pulse:", "Quantity: %s", "Reduces damage taken by a random ally by 50%. Forever.", "Reduces the damage dealt by the furthest enemy by 1 for 3 rounds.", "Reduces the damage taken by the closest ally by 5000% for two rounds.", "Remaining enemy health: %s", "Reset Adventure Reports", "Rewards:", "Select adventurers",
      "Targets:", "The Cursed Adventurer's Guide hungers. Only the tales of your companions' adventures, conveyed in excruciating detail, will satisfy it.", "The guide shows you a number of possible futures. In some, the adventure ends in triumph; in others, a particularly horrible failure.", "The guide shows you many possible futures. Too many. It is impossible to draw conclusions about your party's chances from this.", "To submit your adventure reports,", "Turns survived: %s", "Turns taken: %s", "Use: Feed the Cursed Adventurer's Guide.", "Use: Read the guide, determining the fate of your adventuring party.", "Victorious",
      "Wanted: Adventure Reports", "[CD: %dT]",
}

local L = K and {}
for i=1,K and #K or 0 do
	L[K[i]] = V[i]
end

T.LT = L or nil
