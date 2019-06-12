-- :: REE Core
--  : Shared helper functions for interacting with entities

function PedRemoveHeldWeapon(ped)
    if IsPedArmed(ped, 7) then
        -- If the player is holding weapon, remove it
        SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
    end
end

function PedSpawnInVehicle(ped, vehicleName, x, y, z)
    local model          = vehicleName
    local pedCoords      = GetEntityCoords(ped, false)
    local heading        = GetEntityHeading(ped)

    -- resolve coordinates
    x                    = x or pedCoords.x
    y                    = y or pedCoords.y
    z                    = z or pedCoords.z

    -- Delete current vehicle
    local currentVehicle = GetVehiclePedIsIn(ped, true)
    local speed          = GetEntitySpeed(currentVehicle) or 0

    if IsPedInVehicle(ped, currentVehicle, true) then
        REE.Lib.Native.DeleteVehicle(currentVehicle)
    end

    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(25)
    end

    local vehicle = CreateVehicle(model, x, y, z, heading, true)
    local id      = NetworkGetNetworkIdFromEntity(vehicle)

    SetVehicleForwardSpeed(vehicle, speed)
    SetVehicleEngineOn(vehicle, true, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetVehicleOnGroundProperly(vehicle)
    SetNetworkIdExistsOnAllMachines(id, true)
    SetNetworkIdCanMigrate(id, true)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    TaskWarpPedIntoVehicle(ped, vehicle, -1)

    return vehicle
end

-- expose the REE.Lib.Entity global
REE.Lib.Entity = {
    PedSpawnInVehicle   = PedSpawnInVehicle,
    PedRemoveHeldWeapon = PedRemoveHeldWeapon,
}