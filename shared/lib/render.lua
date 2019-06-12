-- :::: REE Library
-- :: Utilities for making rendering easier

-- Renders a map blip on the player's map and mini-map
--
-- @usage float RenderMapBlip(table{1,2,3} blip, float icon, float color, string text)
-- @module          native
-- @submodule       ree-core
-- @param blip      table{1,2,3}
-- @param icon      float
-- @param color     float
-- @param text      string
--
function RenderMapBlip(blip, icon, color, text)
    -- skip ones that want to be skipped
    if blip.hide == true then return nil end

    -- support blip overrides
    icon              = blip.icon or icon
    color             = blip.color or color
    text              = blip.text or text
    local x, y, z     = table.unpack(blip)
    local blip_entity = AddBlipForCoord(x, y, z)

    SetBlipScale(blip_entity, 1.0)
    SetBlipSprite(blip_entity, icon)
    SetBlipColour(blip_entity, color)
    SetBlipDisplay(blip_entity, 2)
    SetBlipAsShortRange(blip_entity, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip_entity)
    return blip_entity
end

function RenderMapBlipList(list, icon, color, text)
    local rendered = {}
    for _, blip in ipairs(list) do
        table.insert(rendered, RenderMapBlip(blip, icon, color, text))
    end
    return rendered
end

-- Renders a map blip within a certain distance of a player
--
-- @usage float|nil RenderMapBlipInRange(float ped, table{1,2,3} blip, float range, float icon, float color, string text)
-- @module          native
-- @submodule       ree-core
-- @param   ped     float           The ped identifier
-- @param   blip    table{1,2,3}    The blip data
-- @param   range   float           The range to show the blip in
-- @param   icon    float           The icon to display
-- @param   color   float           The color the icon should be
-- @param   text    string          The name of the blip
--
function RenderMapBlipInRange(ped, blip, range, icon, color, text)
    local dist = GetDistanceBetweenPedAndBlip(ped, blip)
    range      = blip.range or range

    if dist <= range then
        local ped_vec = GetEntityCoords(ped, false)
        local pX      = ped_vec.x
        local pY      = ped_vec.y
        local pZ      = ped_vec.z
        local bZ      = blip[3]
        local z_dist  = GetDistanceBetweenCoords(pX, pY, pZ, pX, pY, bZ, true)

        if z_dist > 10 then return nil end

        return RenderMapBlip(blip, icon, color, text)
    end

    return nil
end

-- Renders a list of map blips within a certain distance of a player
--
-- @usage float|nil RenderMapBlipListInRange(float ped, table{1,2,...} list, float range, float icon, float color, string text)
-- @module          native
-- @submodule       ree-core
-- @param   ped     float           The ped identifier
-- @param   list    table{1,2,...}  The list of blip data
-- @param   range   float           The range to show the blip in
-- @param   icon    float           The icon to display
-- @param   color   float           The color the icon should be
-- @param   text    string          The name of the blip
--
function RenderMapBlipListInRange(ped, list, range, icon, color, text)
    local rendered = {}

    for _, blip in pairs(list) do
        local newBlip = RenderMapBlipInRange(ped, blip, range, icon, color, text)
        if newBlip ~= nil then table.insert(rendered, newBlip) end
    end

    return rendered
end

-- :: Export them globally
REE.Lib.Render = {
    RemoveMapBlip            = RemoveMapBlip,
    RenderMapBlip            = RenderMapBlip,
    RenderMapBlipList        = RenderMapBlipList,
    RenderMapBlipInRange     = RenderMapBlipInRange,
    RenderMapBlipListInRange = RenderMapBlipListInRange,
}

