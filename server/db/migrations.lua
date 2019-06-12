local PluginName      = "__ree_core"
local Migrations      = REE.Lib.Migrations

local MigrationSchema = {
    -- 1
    "CREATE TABLE `ree_players` (" ..
            "`id` int NOT NULL AUTO_INCREMENT," ..
            "`active_game_id` int(255) NULL," ..
            "`steam_id` varchar(255) NOT NULL UNIQUE," ..
            "`license_id` varchar(255) NULL UNIQUE," ..
            "`xbl_id` varchar(255) NULL UNIQUE," ..
            "`psn_id` varchar(255) NULL UNIQUE," ..
            "`discord_id` varchar(255) NULL UNIQUE," ..
            "PRIMARY KEY (`id`) );",

    -- 2
    "CREATE TABLE `ree_player_usernames` (" ..
            "`player_id` int NOT NULL," ..
            "`username` varchar(255) NOT NULL UNIQUE," ..
            "`first_seen` DATETIME NOT NULL," ..
            "`last_seen` DATETIME NOT NULL );"
}

MySQL.ready(function()
    REE.Lib.DB.Migrations.CreateMigrationTable()

    TriggerEvent("ree:databaseAvailable")

    for i, sql in pairs(MigrationSchema) do
        TriggerEvent("ree:registerPluginMigration", PluginName, i, sql)
    end

    TriggerEvent("ree:migratePlugin", PluginName)
end)
