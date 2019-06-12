RegisterServerEvent("ree:registerPluginMigration")
AddEventHandler("ree:registerPluginMigration", function(pluginName, id, query)
    print("Plugin " .. pluginName .. " registered a migration with ID " .. id)
    REE.Lib.DB.Migrations.RegisterPluginMigrationRevision(pluginName, id, query)
end)

RegisterServerEvent("ree:migratePlugin")
AddEventHandler("ree:migratePlugin", function(pluginName)
    print("Plugin " .. pluginName .. " requested migrations to be run")
    REE.Lib.DB.Migrations.RunAllPluginMigrations(pluginName)
end)

RegisterNetEvent("ree:getOwnPlayer")
AddEventHandler("ree:getOwnPlayer", function() end)

-- server only event
RegisterServerEvent("ree:getPlayerByData")
AddEventHandler("ree:getPlayerByData", function(playerData, cb)
    cb(REE.Lib.Users.GetPlayerByPlayerData(playerData))
end)