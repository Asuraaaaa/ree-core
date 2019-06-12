AddEventHandler("playerConnecting", function(username, setKickReason, deferral)
    local playerData = GetPlayerIdentifiers(source)
    local player     = REE.Lib.Users.GetPlayerByPlayerData(playerData)

    -- player is nil, let's create one
    if player == nil then
        player = REE.Lib.Users.RegisterPlayer(playerData)
    end

    local n = 0
    for _, fn in pairs(Queue.HandleFns) do
        n = n + 1
        fn(username, setKickReason, deferral)
    end

    if n == 0 then
        deferral.done()
    end

    TriggerEvent("ree:playerConnecting", player)
end)

AddEventHandler("playerDropped", function(_)
    Users:RemovePlayer(source)
end)



