resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
description 'REE Core'
version '1.0.0'

client_scripts {
    --
    -- load shared files
    --
    'shared/globals.lua',
    'shared/data/_globals.lua',
    'shared/data/blips.lua',
    'shared/data/convert.lua',
    'shared/data/emotes.lua',
    'shared/data/weapons.lua',
    'shared/data/locations/_globals.lua',
    'shared/data/locations/atms.lua',
    'shared/data/locations/drugs.lua',
    'shared/data/locations/gas_pumps.lua',
    'shared/data/locations/payphones.lua',
    'shared/data/locations/vending.lua',
    'shared/lib/_globals.lua',
    'shared/lib/db/_globals.lua',
    'shared/lib/db/migrations.lua',
    'shared/lib/anim.lua',
    'shared/lib/coords.lua',
    'shared/lib/entity.lua',
    'shared/lib/format.lua',
    'shared/lib/native.lua',
    'shared/lib/render.lua',
    'shared/lib/users.lua',
    'shared/lib/world.lua',

    'client/_globals.lua',
}

server_scripts {
    -- load dependencies
    '@async/async.lua',
    '@mysql-async/lib/MySQL.lua',

    --
    -- load shared files
    --
    'shared/globals.lua',
    'shared/data/_globals.lua',
    'shared/data/blips.lua',
    'shared/data/convert.lua',
    'shared/data/emotes.lua',
    'shared/data/weapons.lua',
    'shared/data/locations/_globals.lua',
    'shared/data/locations/atms.lua',
    'shared/data/locations/drugs.lua',
    'shared/data/locations/gas_pumps.lua',
    'shared/data/locations/payphones.lua',
    'shared/data/locations/vending.lua',
    'shared/lib/_globals.lua',
    'shared/lib/db/_globals.lua',
    'shared/lib/db/migrations.lua',
    'shared/lib/anim.lua',
    'shared/lib/coords.lua',
    'shared/lib/entity.lua',
    'shared/lib/format.lua',
    'shared/lib/native.lua',
    'shared/lib/render.lua',
    'shared/lib/users.lua',
    'shared/lib/world.lua',

    'server/_global.lua',
    'server/queue.lua',
    'server/session.lua',
    'server/users.lua',
    'server/db/events.lua',
    'server/db/migrations.lua',
}

exports {
    'REE',
    'getREEInstance',
}

server_exports {
    'REE',
    'getREEInstance',
}

dependencies {
    'mysql-async',
    'async',
}

