local spawnedPeds = {}

-------------
-- SPAWN PED
-------------

local NearPed = function(model, coords2)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(50)
    end

    local spawnedPed = CreatePed(model, coords2.x, coords2.y, coords2.z - 1.0, coords2.w, false, false, 0, 0)
    SetEntityAlpha(spawnedPed, 0, false)
    SetRandomOutfitVariation(spawnedPed, true)
    SetEntityCanBeDamaged(spawnedPed, false)
    SetEntityInvincible(spawnedPed, true)
    FreezeEntityPosition(spawnedPed, true)
    SetBlockingOfNonTemporaryEvents(spawnedPed, true)

    SetPedRelationshipGroupHash(spawnedPed, GetPedRelationshipGroupHash(spawnedPed)) -- set relationship group between npc and player
    SetRelationshipBetweenGroups(1, GetPedRelationshipGroupHash(spawnedPed), `PLAYER`)
    if Config.Debug then
        local relationship = GetRelationshipBetweenGroups(GetPedRelationshipGroupHash(spawnedPed), `PLAYER`)
        print(relationship)
    end

    if Config.FadeIn then -- end of relationship group
        for i = 0, 255, 51 do
            Wait(50)
            SetEntityAlpha(spawnedPed, i, false)
        end
    end

    return spawnedPed
end

---------------------
-- CREATE PED 
---------------------

CreateThread(function()
    while true do
        Wait(500)
        for k, v in pairs(Config.Badge) do
            local playerCoords = GetEntityCoords(cache.ped)
            local distance = #(playerCoords - v.coords2.xyz)

            if distance < Config.DistanceSpawn and not spawnedPeds[k] then
                local spawnedPed = NearPed(v.model, v.coords2)
                spawnedPeds[k] = { spawnedPed = spawnedPed }
            end

            if distance >= Config.DistanceSpawn and spawnedPeds[k] then
                if Config.FadeIn then
                    for i = 255, 0, -51 do
                        Wait(50)
                        Citizen.SetEntityAlpha(spawnedPeds[k].spawnedPed, i, false)
                    end
                end
                DeletePed(spawnedPeds[k].spawnedPed)
                spawnedPeds[k] = nil
            end
        end
    end
end)

-----------------------
-- START/STOP RESOURCE
-----------------------

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    for k, v in pairs(spawnedPeds) do
        DeletePed(spawnedPeds[k].spawnedPed)
        spawnedPeds[k] = nil
    end
end)