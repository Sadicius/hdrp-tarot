local RSGCore = exports['rsg-core']:GetCoreObject()

local SpawnedCardBilps = {}
local SpawnedTarotPrompt = {}

---------
-- BLIP 
---------

CreateThread(function()
    for _, v in pairs(Config.CardshopLocation) do
        if Config.UseTarget == true then
            exports['rsg-target']:AddCircleZone(v.id, v.coords, 2, {
                name = v.id,
                debugPoly = false,
            }, {
                options = {
                    {   type = 'client',
                        action = function()
                            TriggerEvent('hdrp-tarot:client:openstore', v.id)
                        end,
                        icon = 'fas fa-comments-dollar',
                        label = v.name,
                    },
                },
            distance = 3,
            })

        else
            exports['rsg-core']:createPrompt(v.id, v.coords, RSGCore.Shared.Keybinds[Config.Keyshop], v.name, {
                type = 'client',
                event = 'hdrp-tarot:client:openstore',
                args = {v.id},
            })
            table.insert(SpawnedTarotPrompt, v.id)
        end
        if v.showblip == true then
            local blipCardshop = BlipAddForCoords(1664425300, v.coords)
            SetBlipSprite(blipCardshop, joaat(v.blipsprite), true)
            SetBlipScale(blipCardshop, v.blipscale)
            SetBlipName(blipCardshop, v.name)
            table.insert(SpawnedCardBilps, blipCardshop)
        end
    end

    for _, v in pairs(Config.Badge) do
        if Config.UseTarget == true then
            exports['rsg-target']:AddCircleZone(v.id, v.coords, 2, {
                name = v.id,
                debugPoly = false,
            }, {
                options = {
                    {   type = 'client',
                        action = function()
                            TriggerServerEvent('Cards2:server:badges', v.id)
                        end,
                        icon = 'fas fa-box',
                        label = Lang:t('client.lang_1')..v.name,
                    },
                },
                distance = 3,
            })

        else
            exports['rsg-core']:createPrompt(v.id, v.coords, RSGCore.Shared.Keybinds[Config.Keytrade], Lang:t('client.lang_1')..v.name, {
                type = 'client',
                serverEvent = 'Cards2:server:badges',
                args = { v.id },
            })
            table.insert(SpawnedTarotPrompt, v.id)

        end
        if v.showblip == true then
            local blipBadge = BlipAddForCoords(1664425300, v.coords)
            SetBlipSprite(blipBadge, joaat(v.blipsprite), true)
            SetBlipScale(blipBadge, v.blipscale)
            SetBlipName(blipBadge, v.name)
            table.insert(SpawnedCardBilps, blipBadge)
        end
    end
end)

----------------------------------------
-- open store with opening hours
----------------------------------------

local OpenTarot = function(id)
    if Config.StoreAlwaysOpen then
        TriggerEvent('hdrp-tarot:client:openMenu', id)
    else
        local hour = GetClockHours()
        if (hour < Config.OpenTime) or (hour >= Config.CloseTime) then
            lib.notify({ title = Lang:t('client.lang_2'), description = Lang:t('client.lang_3')..Config.OpenTime..Lang:t('client.lang_4'), type = 'error', icon = 'fa-solid fa-shop', iconAnimation = 'shake', duration = 7000 })
            return
        end
        TriggerEvent('hdrp-tarot:client:openMenu', id)
    end
end

local GetTarotHours = function() -- get store hours function
    local hour = GetClockHours()
    if Config.StoreAlwaysOpen then
        for k, v in pairs(SpawnedCardBilps) do
            BlipAddModifier(v, joaat('BLIP_MODIFIER_MP_COLOR_8'))
        end
    else
        if (hour < Config.OpenTime) or (hour >= Config.CloseTime) then
            for k, v in pairs(SpawnedCardBilps) do
                BlipAddModifier(v, joaat('BLIP_MODIFIER_MP_COLOR_2'))
            end
        else
            for k, v in pairs(SpawnedCardBilps) do
                BlipAddModifier(v, joaat('BLIP_MODIFIER_MP_COLOR_8'))
            end
        end
    end
end

RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function() -- get shop hours on player loading
    GetTarotHours()
end)

CreateThread(function() -- update shop hourse every min
    while true do
        if Config.StoreAlwaysOpen then
            GetTarotHours()
            Wait(60000) -- every min
        end
        Wait(1000)
    end
end)

---------
--  shop
---------
AddEventHandler('hdrp-tarot:client:openstore', function(id)
    OpenTarot(id) -- Open shop
end)

RegisterNetEvent('hdrp-tarot:client:OpentarotShop')
AddEventHandler('hdrp-tarot:client:OpentarotShop', function()
    local ShopItems = {}
    ShopItems.label = Lang:t('client.lang_5')
    ShopItems.items = Config.TarotShop
    ShopItems.slots = #Config.TarotShop
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "TarotShop_"..math.random(1, 99), ShopItems)
end)

---------
-- MENU
---------

RegisterNetEvent('hdrp-tarot:client:openMenu')
AddEventHandler('hdrp-tarot:client:openMenu', function(menuId)
    local cardMenu = { id = 'cards_main_menu', title = Lang:t('client.lang_6'), options = {} }

    local menu_buttonB = {
        title = Lang:t('client.lang_7'),
        description = Lang:t('client.lang_8'),
        event = 'hdrp-tarot:client:openSellMenu',  -- Evento para abrir el submenú
        args = { menuId },
        icon = 'fa-solid fa-tag',  -- ícono para el menú
        arrow = true
    }
    table.insert(cardMenu.options, menu_buttonB)

    local menu_buttonA = {
        title = Lang:t('client.lang_9'),
        description = Lang:t('client.lang_10'),
        event = 'hdrp-tarot:client:OpentarotShop',  -- Evento para abrir el submenú
        args = { },
        icon = 'fa-solid fa-tag',  -- ícono para el menú
        iconColor = "yellow",
        arrow = true
    }
    table.insert(cardMenu.options, menu_buttonA)

    lib.registerContext(cardMenu)
    lib.showContext('cards_main_menu')
end)

--------
-- NUI
--------

RegisterNUICallback('Rewardtarot', function(data)
    local tarot = data.Tarot
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'flip', 0.9)
    TriggerServerEvent('Cards2:Server:GetTarot', tarot)
end)

RegisterNUICallback('randomCard', function()
    TriggerServerEvent('Cards2:Server:rewarditem')
end)

RegisterNUICallback('CloseNui', function()
    SetNuiFocus(false, false)
end)

RegisterNetEvent('Cards2:Client:CardChoosed')
AddEventHandler('Cards2:Client:CardChoosed', function(card)
    SendNUIMessage({
        open = true,
        class = 'choose',
        data = card,
    })
end)

---------------------
-- OPEN CARDS/ITEMS
---------------------

local handOvercards = function()
    CreateThread(function()
        local animScene = CreateAnimScene('script@beat@town@townRobbery@handover_money', 64, 0, 0, 1)

        if Config.Debug then print('create animScene: ', animScene) end

        local pCoord = GetEntityCoords(cache.ped, 1, 0)
        pCoord = GetOffsetFromEntityInWorldCoords(cache.ped, -0.0497, 1.2016, 0.0)
        local pRot = GetEntityRotation(cache.ped, 2)
        SetAnimSceneOrigin(animScene, pCoord.x, pCoord.y, pCoord.z, pRot.x, pRot.y, pRot.z - 175.66, 2)
        SetAnimSceneEntity(animScene, "pedPlayer", cache.ped, 0)

        local objectModel = GetHashKey('p_cards01x')
        local objMoney = CreateObject(objectModel, pCoord.x, pCoord.y, pCoord.z, 2)
        SetAnimSceneEntity(animScene, "objMoney", objMoney, 0)
        SetEntityVisible(objMoney, false)

        local boneIndex = GetPedBoneIndex(cache.ped, 7966)
        AttachEntityToEntity(objMoney, cache.ped, boneIndex, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1, 0, 0)
        -- SetAnimSceneEntity(animScene, "pedStranger", 24625, 0)

        LoadAnimScene(animScene)
        Wait(1000)
        StartAnimScene(animScene)
        Wait(500)
        SetEntityVisible(objMoney, true)
        Wait(2500)
        SetEntityAsMissionEntity(objMoney, true, true)
        DeleteObject(objMoney)
        Wait(3000)
        Citizen.InvokeNative(0x84EEDB2C6E650000 , animScene) -- _DELETE_ANIM_SCENE

        if Config.Debug then print('delete animScene: ', animScene) end
    end)
end

RegisterNetEvent('Cards2:Client:OpenCards')
AddEventHandler('Cards2:Client:OpenCards', function()
    handOvercards()
    if lib.progressBar({
        duration = 3000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disableControl = true,
        disable = {
            move = true,
            mouse = true,
        },
        label = Lang:t('client.lang_11'),
    }) then
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'boxopen', 0.8)

        Wait(0)
        ClearPedTasks(cache.ped)
    end
end)

local handOverPack = function()
    CreateThread(function()
        local animScene = CreateAnimScene('script@beat@town@townRobbery@handover_money', 64, 0, 0, 1)

        if Config.Debug then print('create animScene: ', animScene) end

        local pCoord = GetEntityCoords(cache.ped, 1, 0)
        pCoord = GetOffsetFromEntityInWorldCoords(cache.ped, -0.0497, 1.2016, 0.0)
        local pRot = GetEntityRotation(cache.ped, 2)
        SetAnimSceneOrigin(animScene, pCoord.x, pCoord.y, pCoord.z, pRot.x, pRot.y, pRot.z - 175.66, 2)
        SetAnimSceneEntity(animScene, "pedPlayer", cache.ped, 0)

        local objectModel = GetHashKey('p_cards_cs01x')
        local objMoney = CreateObject(objectModel, pCoord.x, pCoord.y, pCoord.z, 2)
        SetAnimSceneEntity(animScene, "objMoney", objMoney, 0)
        SetEntityVisible(objMoney, false)

        local boneIndex = GetPedBoneIndex(cache.ped, 7966)
        AttachEntityToEntity(objMoney, cache.ped, boneIndex, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1, 0, 0)
        -- SetAnimSceneEntity(animScene, "pedStranger", 24625, 0)

        LoadAnimScene(animScene)
        Wait(1000)
        StartAnimScene(animScene)
        Wait(500)
        SetEntityVisible(objMoney, true)
        Wait(2500)
        SetEntityAsMissionEntity(objMoney, true, true)
        DeleteObject(objMoney)
        Wait(3000)
        Citizen.InvokeNative(0x84EEDB2C6E650000 , animScene) -- _DELETE_ANIM_SCENE

        if Config.Debug then print('delete animScene: ', animScene) end
    end)
end

RegisterNetEvent('Cards2:Client:OpenPack')
AddEventHandler('Cards2:Client:OpenPack', function()
    handOverPack()
    if lib.progressBar({
        duration = 3000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disableControl = true,
        disable = {
            move = true,
            mouse = true,
        },
        label = Lang:t('client.lang_12'),
    }) then

        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'dealfour', 0.9)

        Wait(500)
        SetNuiFocus(true, true)
        SendNUIMessage({
            open = true,
            class = 'open',
        })

        ClearPedTasks(cache.ped)
        TriggerServerEvent('Cards2:Server:RemoveItem')
    end
end)

---------------------
-- OPEN BAG
---------------------

local handOverBox = function()
    CreateThread(function()
        local animScene = CreateAnimScene('script@beat@town@townRobbery@handover_money', 64, 0, 0, 1)

        if Config.Debug then print('create animScene: ', animScene) end

        local pCoord = GetEntityCoords(cache.ped, 1, 0)
        pCoord = GetOffsetFromEntityInWorldCoords(cache.ped, -0.0497, 1.2016, 0.0)
        local pRot = GetEntityRotation(cache.ped, 2)
        SetAnimSceneOrigin(animScene, pCoord.x, pCoord.y, pCoord.z, pRot.x, pRot.y, pRot.z - 175.66, 2)
        SetAnimSceneEntity(animScene, "pedPlayer", cache.ped, 0)

        local objectModel = GetHashKey('p_cigarettecheapbox01x')
        local objMoney = CreateObject(objectModel, pCoord.x, pCoord.y, pCoord.z, 2)
        SetAnimSceneEntity(animScene, "objMoney", objMoney, 0)
        SetEntityVisible(objMoney, false)

        local boneIndex = GetPedBoneIndex(cache.ped, 7966)
        AttachEntityToEntity(objMoney, cache.ped, boneIndex, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1, 0, 0)
        -- SetAnimSceneEntity(animScene, "pedStranger", 24625, 0)

        LoadAnimScene(animScene)
        Wait(1000)
        StartAnimScene(animScene)
        Wait(500)
        SetEntityVisible(objMoney, true)
        Wait(2500)
        SetEntityAsMissionEntity(objMoney, true, true)
        DeleteObject(objMoney)
        Wait(3000)
        Citizen.InvokeNative(0x84EEDB2C6E650000 , animScene) -- _DELETE_ANIM_SCENE

        if Config.Debug then print('delete animScene: ', animScene) end
    end)
end

RegisterNetEvent('Cards2:client:UseBox')
AddEventHandler('Cards2:client:UseBox', function(data)
    handOverBox()
    if lib.progressBar({
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disableControl = true,
        disable = {
            move = true,
            mouse = true,
        },
        label = Lang:t('client.lang_13'),
    }) then

        local RLBagData = {
            outfitData = {
                ['card_bag']   = { item = 81, texture = 0},  -- Nek / Das
            }
        }

        -- TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'tarot'..data.stashid, {maxweight = Config.StashMaxWeight, slots = Config.StashMaxSlots})
        -- TriggerEvent('inventory:client:SetCurrentStash', 'tarot'..data.stashid)

        local builder = RSGCore.Functions.GetPlayerData().citizenid

        TriggerServerEvent("inventory:server:OpenInventory", "stash", "tarot"..builder, {maxweight = Config.StashMaxWeight, slots = Config.StashMaxSlots})
        TriggerEvent("inventory:client:SetCurrentStash", "tarot"..builder)

        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'snap', 1.2)

        lib.notify({ title = Lang:t('client.lang_14'), type = 'inform', duration = 5000 })

        Wait(5000)
        ClearPedTasks(cache.ped)
    end
end)

-- SOUNDS
RegisterNetEvent('hdrp-tarot:client:badgesound')
AddEventHandler('hdrp-tarot:client:badgesound', function()
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'badge', 0.8)
end)

------------- 
-- EXTRA MOVE 
-------------

local cardVisible = false

RegisterNetEvent('hdrp-tarot:Client:OpenCardsIndivudal')
AddEventHandler('hdrp-tarot:Client:OpenCardsIndivudal', function(cardImagePath)
    cardVisible = not cardVisible
    SendNUIMessage({
        action = cardVisible and "display_card" or "hide_card",
        card = cardImagePath
    })
    SetNuiFocus(cardVisible, cardVisible)
end)

RegisterNUICallback('closeCard', function(data, cb)
    cardVisible = false
    SetNuiFocus(false, false)
    cb('ok')
end)

-----------------------
-- START/STOP RESOURCE
-----------------------
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    TriggerEvent('RSGCore:client:OnPlayerLoaded')
end)

AddEventHandler('RSGCore:Client:OnPlayerLoaded', function()
    PlayerData = RSGCore.Functions.GetPlayerData()
end)

RegisterNetEvent('RSGCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    cardVisible = false
    SetNuiFocus(false, false)

    ClearPedTasks(cache.ped)
end)