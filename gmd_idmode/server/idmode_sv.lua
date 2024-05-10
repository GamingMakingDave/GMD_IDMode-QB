QBCore = exports['qb-core']:GetCoreObject()

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

function GetdiscordID(PlayerID)
    local  discordID = ''

    for _, v in pairs(GetPlayerIdentifiers(PlayerID)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordID = v
            break
        end
    end
    
    return discordID
end

function GetdiscordName(discordIDentifier)
    local _, _, userId = string.find(discordIDentifier, "discord:(%d+)")
    local Async = false
    local discordName = ''

    local url = ('https://discord.com/api/guilds/%s/members/%s'):format(Config.GuildId, userId)
    PerformHttpRequest(url, function(statusCode, response, headers)
        if statusCode == 200 then
            local discordData = json.decode(response)

            local filteredData = {
                user = {
                    global_name = discordData['user']['global_name'],
                    id = discordData['user']['id']
                }
            }

            discordName = filteredData.user.global_name
        else
            debugprint("Fehler beim Abrufen der Discord-Daten:", statusCode)
        end

        Async = true
    end, "GET", "", {["Authorization"] = "Bot " .. Config.DiscordBotToken})

    while not Async do 
        Wait(1)
    end

    return discordName
end


QBCore.Functions.CreateCallback('GMD_IDMode:getAllPlayerInfos', function(src, cb, data)
    local allPlayerInfo = {}
    
    for _, xPlayer in pairs(QBCore.Functions.GetPlayers()) do
        local stopQuery = false

        for i,v in ipairs(data) do
            if xPlayer  == v.id then 
                stopQuery = true
            end
        end

        if not stopQuery then
            local Player = QBCore.Functions.GetPlayer(xPlayer)
            local playerName = tostring(Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname)
            local playerGroup = QBCore.Functions.GetPermission(xPlayer)
            local discordID = GetdiscordID(xPlayer)
            local discordName = GetdiscordName(discordID)
            local realrank = nil
            for k, v in pairs(Config.canTagUse) do 
                for x, y in pairs(playerGroup) do
                    if x == k then
                        --print("Checked rank:", x, y, "Config Rank: ", k)
                        if y == true then
                            realrank = x 
                            --print("Player group found:", realrank)
                        end
                    end
                end
            end

            if not realrank then
                realrank = 'user'
            end

            while discordName == nil do 
                Wait(1)
            end

            local playerInfo = {
                id = xPlayer,
                name = playerName,
                group = realrank,
                dcname = discordName
            }

            table.insert(allPlayerInfo, playerInfo)
        end

        Wait(100)
    end

    for k,v in ipairs(allPlayerInfo) do
        table.insert(data, v)
    end 
      
    cb(data)
end)

QBCore.Functions.CreateCallback('GMD_IDMode:hasPlayerGroup', function(src, cb, data)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local ranks = QBCore.Functions.GetPermission(src)
    local playerGroup = 'user'  -- Initialize playerGroup with 'user'
    
    for k, v in pairs(Config.canTagUse) do 
        for x, y in pairs(ranks) do
            if x == k then
                --print("Checked rank:", x, y, "Config Rank: ", k)
                if y == true then
                    playerGroup = x 
                    --print("Player group found:", playerGroup)
                    cb(playerGroup)  -- Call the callback with the found group
                    return  -- Exit the function after finding the group
                end
            end
        end
    end
    
    -- If no matching group is found, cb with 'user'
    --print("No matching group found, defaulting to user")
    cb(playerGroup)
end)
