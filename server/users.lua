Users = { Data = {} }

function Users:GetPlayers()
    return self.Data
end

function Users:Poll()
    local players = GetPlayers()

    existingPlayers = {}

    for id, data in pairs(Users.Data) do
        if data.Player ~= nil then
            table.insert(existingPlayers, id)
        end
    end

    function PlayerIdExists(id)
        for _, existingID in pairs(existingPlayers) do
            if existingID == id then
                return true
            end
        end

        return false
    end

    for _, id in pairs(players) do
        if not PlayerIdExists(id) then
            self:AddPlayer(id)
        end
    end
end

function Users:AddPlayer(playerId)
    local playerData = GetPlayerIdentifiers(playerId)
    local player     = GetPlayerByPlayerData(playerData)

    if player.active_game_id ~= playerId then
        REE.Lib.Users.SetPlayerInGameID(player.id, playerId)
    end

    self.Data[playerId] = { Player = player }
end

function Users:GetPlayer(playerId)
    return self.Data[playerId] or nil
end

function Users:SavePlayer(playerId, data)
    self.Data[playerId] = data
end

function Users:RemovePlayer(playerId)
    self.Data[playerId] = nil
end

Citizen.CreateThread(function()
    Users:Poll()

    while true do
        Citizen.Wait(30 * 1000)
        Users:Poll()
    end
end)

