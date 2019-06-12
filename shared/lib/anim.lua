-- :: REE Core
--  : Shared animation library functions

function PedPlayEmote(ped, emoteName, immediately)
    -- stop any previous emote
    PedStopEmote(immediately)

    -- make sure to remove their weapon
    REE.Lib.Entity.PedRemoveHeldWeapon(ped)

    -- start the scenario
    TaskStartScenarioInPlace(ped, REE.Data.Emotes[emoteName], 0, true)
end

function PedStopEmote(ped, immediately)
    if immediately then
        ClearPedTasksImmediately(ped)
    else
        ClearPedTasks(ped)
    end
end

-- expose REE.Lib.Anim globally
REE.Lib.Anim = {
    PedPlayEmote = PedPlayEmote,
    PedStopEmote = PedStopEmote,
}