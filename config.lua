Config = {}

Config.UseOkokTextUI = false -- true = okokTextUI (I recommend you using this since it is way more optimized than the default ShowHelpNotification) | false = ShowHelpNotification

Config.Key = 38 -- [E] Key to open the interaction, check here the keys ID: https://docs.fivem.net/docs/game-references/controls/#controls

Config.HideMinimap = true -- If true it'll hide the minimap when the Crafting menu is opened

Config.ShowBlips = false -- If true it'll show the crafting blips on the map

Config.ShowFloorBlips = true -- If true it'll show the crafting markers on the floor

Config.NotificationType = "esx"

Config.ItemNames = {
    ['witem_canon'] = "Canon",
    ['witem_poigneepistol'] = 'Poignée pistolet',
    ['witem_mire'] = "Mire",
    ['witem_moulepistol'] = 'Moule pistolet',
    ['witem_ressort'] = "Ressort",
    ['witem_barillet'] = 'Barillet',
    
    -- Matériaux pour le craft
    ['metal'] = "Métal",
    ['steel'] = "Acier",
    ['gunframe'] = "Châssis d'arme",
    ['trigger'] = "Détente",
    ['weaponstock'] = "Crosse d'arme",
    ['gunbarrel'] = "Canon d'arme",
    ['grip'] = "Poignée",
    ['metalspring'] = "Ressort en métal",

    -- Armes craftables
    ['weapon_pistol'] = 'Pistolet',
    ['weapon_appistol'] = 'AP Pistolet',
    ['weapon_snspistol'] = 'SNS Pistolet',
    ['weapon_microsmg'] = 'Micro SMG',
    ['weapon_machinepistol'] = 'Pistolet Mitrailleur',
    ['weapon_sawnoffshotgun'] = 'Fusil à canon scié',
    ['weapon_assaultrifle'] = 'Fusil d\'assaut',
    ['weapon_specialcarbine'] = 'Carabine spéciale',
}


Config.Crafting = {
	--[[ {
		coordinates = vector3(-809.4, 190.3, 72.5), -- coordinates of the table
		radius = 1, -- radius of the table
		maxCraftRadius = 5, -- if you are further it will stop the craft
		showBlipRadius = 50,
		blip = {blipId = 89, blipColor = 3, blipScale = 0.9, blipText = "Crafting"}, -- to get blips and colors check this: https://wiki.gtanet.work/index.php?title=Blips
		tableName = 'Gun labo', -- Title
		tableID = 'general1', -- make a different one for every table with NO spaces
		crafts = { -- What items are available for crafting and the recipe
			{
				item = 'witem_canon', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 15, -- Time to craft (in ms)
				recipe = { -- Recipe to craft it
					--{'witem_canon', 1, false}, -- item/amount/if the item should be removed when crafting
					{'witem_aciercompact', 3, true},
					{'witem_acier', 3, true},
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'witem_poigneepistol', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 20, -- Time to craft (in seconds)
				recipe = { -- Recipe to craft it
					--{'witem_poigneepistol', 1, false}, -- item/amount/if the item should be removed when crafting
					{'witem_aciercompact', 2, true},
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'witem_mire', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 20, -- Time to craft (in seconds)
				recipe = { -- Recipe to craft it
					--{'witem_mire', 1, false}, -- item/amount/if the item should be removed when crafting
					{'witem_aciercompact', 1, true},
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'witem_moulepistol', -- Item id and name of the image
				amount = 2,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 30, -- Time to craft (in seconds)
				recipe = { -- Recipe to craft it
					--{'witem_moulepistol', 1, false}, -- item/amount/if the item should be removed when crafting
					{'witem_titane', 1, true},
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'witem_ressort', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 20, -- Time to craft (in seconds)
				recipe = { -- Recipe to craft it
					--{'witem_ressort', 1, false}, -- item/amount/if the item should be removed when crafting
					{'witem_acier', 10, true},
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'witem_barillet', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = true, -- if true = is item | if false = is weapon
				time = 20, -- Time to craft (in seconds)
				recipe = { -- Recipe to craft it
					--{'witem_barillet', 1, false}, -- item/amount/if the item should be removed when crafting
					{'witem_aciercompact', 1, true},
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
			{
				item = 'weapon_pistol', -- Item id and name of the image
				amount = 1,
				successCraftPercentage = 100, -- Percentage of successful craft 0 = 0% | 50 = 50% | 100 = 100%
				isItem = false, -- if true = is item | if false = is weapon
				time = 20, -- Time to craft (in seconds)
				recipe = { -- Recipe to craft it
					--{'witem_barillet', 1, false}, -- item/amount/if the item should be removed when crafting
					{'gold', 1, true},
				},
				job = { -- What jobs can craft this item in this workbench
					''
				},
			},
		},
	}, ]]
	{
		coordinates = vector3(-585.4091796875, -1599.8332519531, 27.010793685913), -- coordinates of the table
		radius = 1, -- radius of the table
		maxCraftRadius = 5, -- if you are further it will stop the craft
		showBlipRadius = 100,
		blip = {blipId = 89, blipColor = 3, blipScale = 0.9, blipText = "Crafting"}, -- to get blips and colors check this: https://wiki.gtanet.work/index.php?title=Blips
		tableName = 'Composant d\'arme', -- Title
		tableID = 'general1', -- make a different one for every table with NO spaces
		crafts = { -- What items are available for crafting and the recipe
		{
			item = 'weapon_pistol',
			amount = 1,
			successCraftPercentage = 100,
			isItem = false,
			time = 8,
			recipe = {
				{'metal', 5, true},
				{'steel', 3, true},
				{'gunframe', 1, true},
				{'trigger', 1, true},
				{'weaponstock', 1, true},
			},
			job = {''},
		},
		{
			item = 'weapon_appistol',
			amount = 1,
			successCraftPercentage = 100,
			isItem = false,
			time = 10,
			recipe = {
				{'metal', 6, true},
				{'steel', 4, true},
				{'gunframe', 1, true},
				{'trigger', 1, true},
				{'weaponstock', 1, true},
			},
			job = {''},
		},
		{
			item = 'weapon_snspistol',
			amount = 1,
			successCraftPercentage = 100,
			isItem = false,
			time = 6,
			recipe = {
				{'metal', 4, true},
				{'steel', 2, true},
				{'gunframe', 1, true},
				{'trigger', 1, true},
			},
			job = {''},
		},
		{
			item = 'weapon_microsmg',
			amount = 1,
			successCraftPercentage = 100,
			isItem = false,
			time = 12,
			recipe = {
				{'metal', 8, true},
				{'steel', 6, true},
				{'gunbarrel', 1, true},
				{'grip', 1, true},
				{'gunframe', 1, true},
				{'weaponstock', 1, true},
				{'trigger', 1, true},
			},
			job = {''},
		},
		{
			item = 'weapon_machinepistol',
			amount = 1,
			successCraftPercentage = 100,
			isItem = false,
			time = 12,
			recipe = {
				{'metal', 9, true},
				{'steel', 7, true},
				{'gunbarrel', 1, true},
				{'grip', 1, true},
				{'gunframe', 1, true},
				{'weaponstock', 1, true},
				{'trigger', 1, true},
			},
			job = {''},
		},
		{
			item = 'weapon_sawnoffshotgun',
			amount = 1,
			successCraftPercentage = 100,
			isItem = false,
			time = 14,
			recipe = {
				{'metal', 10, true},
				{'steel', 8, true},
				{'gunbarrel', 1, true},
				{'grip', 1, true},
				{'gunframe', 1, true},
				{'weaponstock', 1, true},
				{'trigger', 1, true},
			},
			job = {''},
		},
		{
			item = 'weapon_assaultrifle',
			amount = 1,
			successCraftPercentage = 100,
			isItem = false,
			time = 18,
			recipe = {
				{'metal', 15, true},
				{'steel', 12, true},
				{'gunbarrel', 1, true},
				{'grip', 1, true},
				{'gunframe', 1, true},
				{'weaponstock', 1, true},
				{'trigger', 1, true},
				{'metalspring', 3, true},
			},
			job = {''},
		},
		{
			item = 'weapon_specialcarbine',
			amount = 1,
			successCraftPercentage = 100,
			isItem = false,
			time = 20,
			recipe = {
				{'metal', 18, true},
				{'steel', 15, true},
				{'gunbarrel', 1, true},
				{'grip', 1, true},
				{'gunframe', 1, true},
				{'weaponstock', 1, true},
				{'trigger', 1, true},
				{'metalspring', 3, true},
			},
			job = {''},
		},		
		},
	},
}

-------------------------- DISCORD LOGS

-- To set your Discord Webhook URL go to server.lua, line 3

Config.BotName = 'ServerName' -- Write the desired bot name

Config.ServerName = 'ServerName' -- Write your server's name

Config.IconURL = '' -- Insert your desired image link

Config.DateFormat = '%d/%m/%Y [%X]' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

-- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html

Config.StartCraftWebhookColor = '16127'

Config.ConcludeCraftWebhookColor = '65352'

Config.AnticheatProtectionWebhookColor = '16776960'

Config.FailWebhookColor = '16711680'