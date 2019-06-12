function DeleteVehicle(veh_entity)
    SetEntityAsMissionEntity(veh_entity, true, true)
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh_entity))
end

function PromptUserTextInput()
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)

    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end

    if (GetOnscreenKeyboardResult()) then
        return GetOnscreenKeyboardResult()
    end

    return nil
end

function GetEntityPositionStreetNames(entity)
    local pos              = GetEntityCoords(entity, false)
    local streetA, streetB = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z,
                                                  Citizen.PointerValueInt(), Citizen.PointerValueInt())

    if streetA then streetA = GetStreetNameFromHashKey(streetA) end
    if streetB then streetB = GetStreetNameFromHashKey(streetB) end

    return { A = streetA, B = streetB }
end

REE.Lib.Native = {
    DeleteVehicle                = DeleteVehicle,
    PromptUserTextInput          = PromptUserTextInput,
    GetEntityPositionStreetNames = GetEntityPositionStreetNames,
}