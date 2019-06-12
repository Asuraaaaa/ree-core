-- code that should be applied to every user
Citizen.CreateThread(function()
    SetMaxWantedLevel(0)
    REE.Booted = true
end)

