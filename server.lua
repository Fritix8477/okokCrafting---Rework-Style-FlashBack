ESX = exports['es_extended']:getSharedObject()

local Webhook = ''
local sessions = {}

RegisterServerEvent('fb_crafting:craftStartItem')
AddEventHandler('fb_crafting:craftStartItem',function()
    sessions[source] = {
        stoppedCraft = false,
        isCrafting = true,
        last = GetGameTimer(),
    }
end)

RegisterServerEvent('fb_crafting:craftStopItem')
AddEventHandler('fb_crafting:craftStopItem',function()
    sessions[source] = {
        stoppedCraft = true,
        isCrafting = false,
    }
end)

RegisterServerEvent('fb_crafting:failedCraft')
AddEventHandler('fb_crafting:failedCraft',function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Webhook ~= '' then
        local identifierlist = ExtractIdentifiers(xPlayer.source)
        local data = {
            playerid = xPlayer.source,
            identifier = identifierlist.license:gsub("license2:", ""),
            discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
            type = "failed",
            item = item,
        }
        noSession(data)
    end
end)

RegisterServerEvent('fb_crafting:craftItemDeath')
AddEventHandler('fb_crafting:craftItemDeath',function(queueClient)
    local xPlayer = ESX.GetPlayerFromId(source)
    local queue = queueClient

    if sessions[source] then
        if sessions[source].stoppedCraft then
            for k,v in ipairs(queue) do
                for k2,v2 in ipairs(v.recipe) do
                    exports.ox_inventory:AddItem(source, v2[1], v2[2])
                end
            end
            SendNotification(source, "CRAFTING", "You died, all crafting items were given back", 5000, 'info')
            sessions[xPlayer.source] = nil
        end
    else
        if Webhook ~= '' then
            local identifierlist = ExtractIdentifiers(xPlayer.source)
            local data = {
                playerid = xPlayer.source,
                identifier = identifierlist.license:gsub("license2:", ""),
                discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
                type = "Death",
            }
            noSession(data)
        end
        SendNotification(source, "CRAFTING", "No session!", 5000, 'error')
    end
end)

RegisterServerEvent('fb_crafting:craftItemFinished')
AddEventHandler('fb_crafting:craftItemFinished', function(item, crafts, itemName, isItem, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local timeToCraft = 600000

    if type(amount) ~= "number" or amount < 1 then
        amount = 1
    end

    if sessions[source] then
        for k, v in ipairs(crafts) do
            if v.item == item then
                timeToCraft = v.time * 1000
            end
        end
        sessions[source].last = GetGameTimer() - sessions[source].last

        if sessions[source].last >= timeToCraft then
            if Webhook ~= '' then
                local identifierlist = ExtractIdentifiers(xPlayer.source)
                local data = {
                    playerid = xPlayer.source,
                    identifier = identifierlist.license:gsub("license2:", ""),
                    discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
                    type = "conclude-crafting",
                    itemName = itemName,
                    time = sessions[xPlayer.source].last,
                }
                noSession(data)
            end

            if exports.ox_inventory:CanCarryItem(source, item, amount) then
                exports.ox_inventory:AddItem(source, item, amount)
                SendNotification(source, "CRAFTING", "Tu as crafté x" .. amount .. " " .. itemName, 5000, 'success')
            else
                SendNotification(source, "CRAFTING", "Inventaire plein, item perdu !", 5000, 'error')
            end
        
            sessions[xPlayer.source] = nil
        else
            SendNotification(source, "CRAFTING", "Anti-cheat protection activée !", 5000, 'error')
        end
    end
end)

ESX.RegisterServerCallback("fb_crafting:inv2", function(source, cb, item)
    local itemData = exports.ox_inventory:GetItem(source, item)
    if itemData then
        cb({name = itemData.name, count = itemData.count})
    else
        cb({name = item, count = 0})
    end
end)

ESX.RegisterServerCallback("fb_crafting:itemNames", function(source, cb)
    local itemNames = {}

    for itemName, itemData in pairs(exports.ox_inventory:Items()) do
        itemNames[itemName] = itemData.label
    end

    cb(itemNames)
end)

ESX.RegisterServerCallback("fb_crafting:CanCraftItem", function(source, cb, itemID, recipe, itemName, amount)
    amount = tonumber(amount) or 1

    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        cb(false)
        return
    end
    if type(recipe) ~= "table" then
        cb(false)
        return
    end
    local canCraft = true

    local itemData = exports.ox_inventory:GetItem(source, itemID)
    if not itemData then
        cb(false)
        return
    end
    for k, v in pairs(recipe) do
        if type(v) ~= "table" then
            canCraft = false
            break
        end
        local item = exports.ox_inventory:GetItem(source, v[1])
        local neededAmount = v[2] * amount

        if not item or item.count < neededAmount then
            canCraft = false
            break
        end
    end
    if canCraft then
        if exports.ox_inventory:CanCarryItem(source, itemID, amount) then
            for k, v in pairs(recipe) do
                if type(v) == "table" and v[3] == "true" then
                    exports.ox_inventory:RemoveItem(source, v[1], v[2] * amount)
                end
            end
            local craftTime = (15 * amount) * 1000
            cb(true, craftTime)

            TriggerClientEvent("fb_crafting:craftFinished", source, itemID, amount, itemName[itemID], craftTime)
        else
            cb(false)
            SendNotification(source, "CRAFTING", "Tu ne peux pas porter x" .. amount .. " " .. itemName[itemID], 5000, 'error')
        end
    else
        cb(false)
        SendNotification(source, "CRAFTING", "Tu n'as pas assez de matériaux", 5000, 'error')
    end
end)

-------------------------- IDENTIFIERS

function ExtractIdentifiers(id)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(id) - 1 do
        local playerID = GetPlayerIdentifier(id, i)

        if string.find(playerID, "steam") then
            identifiers.steam = playerID
        elseif string.find(playerID, "ip") then
            identifiers.ip = playerID
        elseif string.find(playerID, "discord") then
            identifiers.discord = playerID
        elseif string.find(playerID, "license") then
            identifiers.license = playerID
        elseif string.find(playerID, "xbl") then
            identifiers.xbl = playerID
        elseif string.find(playerID, "live") then
            identifiers.live = playerID
        end
    end

    return identifiers
end

-------------------------- NO SESSION WEBHOOK

function noSession(data)
    local color = '65352'
    local category = 'test'

    if data.type == 'Death' then
        color = Config.AnticheatProtectionWebhookColor
        category = 'Tried to receive the crafting items without starting a crafting, he might be cheating'
    elseif data.type == 'conclude' then
        color = Config.AnticheatProtectionWebhookColor
        category = 'Tried to conclude a crafting without starting it first, he might be cheating'
    elseif data.type == 'crafted-soon' then
        color = Config.AnticheatProtectionWebhookColor
        category = 'Concluded the crafting of '..data.itemName..' after '..data.time_taken..'ms while it takes '..data.time_needed..'ms to craft, he might be cheating'
    elseif data.type == 'crafting' then
        color = Config.StartCraftWebhookColor
        category = 'Added '..data.itemName..' to queue'
    elseif data.type == 'conclude-crafting' then
        color = Config.ConcludeCraftWebhookColor
        category = 'Crafted a '..data.itemName..' after '..data.time..'ms'
    elseif data.type == 'failed' then
        color = Config.FailWebhookColor
        category = 'Failed to craft a '..data.item
    end
    
    local information = {
        {
            ["color"] = color,
            ["author"] = {
                ["icon_url"] = Config.IconURL,
                ["name"] = Config.ServerName..' - Logs',
            },
            ["title"] = 'CRAFTING',
            ["description"] = '**Action:** '..category..'\n\n**ID:** '..data.playerid..'\n**Identifier:** '..data.identifier..'\n**Discord:** '..data.discord,
            ["footer"] = {
                ["text"] = os.date(Config.DateFormat),
            }
        }
    }

    PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end

function SendNotification(source, title, message, time, type)
    if Config.NotificationType == "okokNotify" then
        SendNotification( source, title, message, time, type)
    elseif Config.NotificationType == "esx" then
        TriggerClientEvent('esx:showNotification', source, message)
    end
end

RegisterServerEvent('fb_crafting:action')
AddEventHandler('fb_crafting:action', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if data.action == "close" then
        print("")
    end
end)

