Users = {}

function _GetIdentifiersFromPlayerData(playerData)
    local result = { steam = nil, gameLicense = nil, xbox = nil,
                     live  = nil, discord = nil, ip = nil }

    for _, data in pairs(playerData) do
        if string.match(data, "steam") then
            result.steam = data
        elseif string.match(data, "license") then
            result.gameLicense = data
        elseif string.match(data, "xbl") then
            result.xbox = data
        elseif string.match(data, "live") then
            result.live = data
        elseif string.match(data, "discord") then
            result.discord = data
        elseif string.match(data, "ip") then
            result.ip = data
        end
    end

    return result
end

function GetPlayerByPlayerData(playerData)
    local data    = _GetIdentifiersFromPlayerData(playerData)
    local steam   = data.steam
    local license = data.gameLicense

    -- we've got nothin, return nil
    if steam == nil and license == nil then
        error("Failed to retrieve player from data, no usable data found")
        return nil
    end

    local player
    local playerRows = MySQL.Sync.fetchAll(
            "SELECT * FROM " .. _TableNames.Players .. " WHERE steam_id = @steam OR license_id = @license LIMIT 1",
            { ["@steam"] = steam, ["@license"] = license })

    for _, row in pairs(playerRows) do
        player = row
        break
    end

    return player
end

function GetPlayerByServerID(id)
    local playerDataRaw = GetPlayerIdentifiers(id)
    if playerDataRaw == nil then return nil end
    return GetPlayerByPlayerData(playerData)
end

function GetPlayerById(id)

end

function SetPlayerInGameID(playerID, id)
    MySQL.Sync.execute("UPDATE " .. _TableNames.Players .. " SET active_game_id = @game_id WHERE id = @id",
                       { ["@id"] = playerID, ["@game_id"] = id })
end

function RegisterPlayer(playerData)
    local data = _GetIdentifiersFromPlayerData(playerData)

    MySQL.Sync.execute(
            "INSERT INTO " .. _TableNames.Players .. " (active_game_id, steam_id, license_id, " ..
                    "xbl_id, psn_id, discord_id) VALUES (@game_id, @steam_id, @license_id, @xbl_id, " ..
                    "@psn_id, @discord_id)",
            { ["@game_id"] = nil, ["@steam_id"] = data.steam, ["@license_id"] = data.gameLicense,
              ["@xbl_id"]  = data.xbox, ["@psn_id"] = data.live, ["@discord_id"] = data.discord })

    return GetPlayerByPlayerData(playerData)
end

REE.Lib.Users = {
    GetPlayerByPlayerData = GetPlayerByPlayerData,
    GetPlayerById         = GetPlayerById,
    SetPlayerInGameID     = SetPlayerInGameID,
    RegisterPlayer        = RegisterPlayer,
}
