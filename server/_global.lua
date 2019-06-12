AddEventHandler("ree:setInstance", function(_REE)
    Citizen.Trace("Updating server instance!")
    Citizen.Trace(dump(_REE))

    REE = _REE
end)

