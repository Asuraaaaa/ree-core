-- :: REE Core
--  : Shared coordinate library functions
--

-- Get the distance between a ped and a blip
--
-- @usage float GetDistanceBetweenCoords(float ped, table{1,2,3} blip, bool calc_z)
-- @module          native
-- @submodule       ree-core
-- @param ped       float
-- @param blip      float
-- @param calc_z    bool|nil
--
function GetDistanceBetweenPedAndBlip(ped, blip, calc_z)
    -- check for valid ped
    if ped == nil then
        error("Invalid ped passed to GetDistanceBetweenPedAndBlip()")
    end

    -- check for valid blip
    if blip == nil or #blip < 3 then
        error("Invalid blip passed to GetDistanceBetweenPedAndBlip()")
    end

    -- false, always grab it just in case
    local vec        = GetEntityCoords(ped, false)
    local pX         = vec.x
    local pY         = vec.y
    local pZ         = vec.z
    local bX, bY, bZ = table.unpack(blip)

    -- default to true, so blips aren't triggered on different floors
    return GetDistanceBetweenCoords(pX, pY, pZ, bX, bY, bZ, calc_z or true)
end

function GetCompassDirectionForEntity(entity)
    local heading = GetEntityHeading(entity)
    local dir     = "??"

    if heading >= 345 or heading < 15 then
        dir = "N"
    elseif heading >= 15 and heading < 45 then
        dir = "NW"
    elseif heading >= 45 and heading < 105 then
        dir = "W"
    elseif heading >= 105 and heading < 135 then
        dir = "SW"
    elseif heading >= 135 and heading < 225 then
        dir = "S"
    elseif heading >= 225 and heading < 255 then
        dir = "SE"
    elseif heading >= 255 and heading < 315 then
        dir = "E"
    elseif heading >= 315 and heading < 345 then
        dir = "NE"
    end

    return dir
end


-- Set the global entry
REE.Lib.Coords = {
    GetCompassDirectionForEntity = GetCompassDirectionForEntity,
    GetDistanceBetweenPedAndBlip = GetDistanceBetweenPedAndBlip,
}

