local Migrations = { Plugins = {}, KnownToExist = {} }

function Migrations.CreateMigrationTable()
    MySQL.Sync.execute(
            "CREATE TABLE IF NOT EXISTS `ree_migrations` (`id` int NOT NULL AUTO_INCREMENT," ..
                    "`plugin_name` varchar(255) NOT NULL UNIQUE,`revision` varchar(255) NOT NULL," ..
                    "PRIMARY KEY (`id`));")
end

function Migrations.RegisterPluginMigration(pluginName)
    local currentRevision = Migrations.GetActivePluginMigrationVersion(pluginName)
    if currentRevision == nil then
        MySQL.Sync.execute(
                "INSERT INTO " .. _TableNames.Migrations .. " (plugin_name, revision) VALUES (@pluginName, @revision)",
                { ["@pluginName"] = pluginName, ["@revision"] = 0 })
    end

    return true
end

function Migrations.GetActivePluginMigrationVersion(pluginName)
    local rows = MySQL.Sync.fetchAll(
            "SELECT revision FROM " .. _TableNames.Migrations .. " WHERE plugin_name = @pluginName LIMIT 1",
            { ["@pluginName"] = pluginName })

    for _, row in pairs(rows) do
        if row.revision then
            return tonumber(row.revision)
        end
    end
end

function Migrations.RegisterPluginMigrationRevision(pluginName, id, query)
    if Migrations.Plugins[pluginName] == nil then
        Migrations.Plugins[pluginName] = {}
    end

    Migrations.Plugins[pluginName][id] = query
end

function Migrations.RunAllPluginMigrations(pluginName)
    local currentRevision = Migrations.GetActivePluginMigrationVersion(pluginName)
    if currentRevision == 0 or currentRevision == nil then
        Migrations.RegisterPluginMigration(pluginName)
        currentRevision = 0
    end

    local migrations      = Migrations.Plugins[pluginName]
    local totalMigrations = 0

    for _, _ in pairs(migrations) do
        totalMigrations = totalMigrations + 1
    end

    for id, sql in ipairs(migrations) do
        if id > currentRevision then
            -- migrate
            print("Migrating plugin " .. pluginName .. " (" .. id .. " of " .. totalMigrations .. ")")
            MySQL.Sync.execute(sql)
            MySQL.Sync.execute("UPDATE " .. _TableNames.Migrations .. " SET revision = @revision WHERE plugin_name = @pluginName",
                               { ["@revision"] = id, ["@pluginName"] = pluginName })
        end
    end
end

REE.Lib.DB.Migrations = Migrations