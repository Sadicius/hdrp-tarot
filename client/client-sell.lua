local RSGCore = exports['rsg-core']:GetCoreObject()

--------------------
-- sell vendor menu
--------------------

RegisterNetEvent('hdrp-tarot:client:openSellMenu') -- change resource
AddEventHandler('hdrp-tarot:client:openSellMenu', function(menuId)
    
    local actualMenuId
    if type(menuId) == "table" then actualMenuId = tostring(menuId[1]) else actualMenuId = tostring(menuId) end
    if not actualMenuId then print("Error: menuId Is nil", actualMenuId)  return end
    RSGCore.Functions.TriggerCallback('hdrp-tarot:server:GetItems', function(result)
        if not result or not result.items or #result.items == 0 then lib.notify({ title = Lang:t('client.lang_15_0'), description = Lang:t('client.lang_15_1'), type = 'error', duration = 7000 })  return end
        for _, v in pairs(Config.CardshopLocation) do --  change resource config
            if v.id == actualMenuId then
                TriggerEvent('hdrp-tarot:client:ShopSell', result.items) -- change resource
                break
            end
        end
    end, actualMenuId)
end)

RegisterNetEvent('hdrp-tarot:client:ShopSell') -- change resource
AddEventHandler('hdrp-tarot:client:ShopSell', function(sellId)
    local itemsList = sellId
    if type(sellId) == "table" then itemsList = sellId end

    local sellSubMenu = {
        id = 'items_sell_menu',
        title = Lang:t('client.lang_15'),
        description = Lang:t('client.lang_16'),
        menu = 'tarot_main_menu', -- change resource menu 
        options = {},
        onBack = function()
            
        end,
    }

    local subOptionAll = {
        title = Lang:t('client.lang_17'),
        description = Lang:t('client.lang_18'),
        event = 'hdrp-tarot:client:sellAll', -- change resource
        args = { itemsList },
        icon = 'fa-solid fa-handshake',
        arrow = true,
    }

    table.insert(sellSubMenu.options, subOptionAll)

    if Config.Debug then print('sellId:', json.encode(itemsList)) end
    for _, item in ipairs(itemsList) do

        if Config.Debug then print('Id:', json.encode(item)) end

        if item and item.name then
            local itemLabel = RSGCore.Shared.Items[tostring(item.name)].label
            local itemImage = "nui://" .. Config.img .. RSGCore.Shared.Items[tostring(item.name)].image
            --local itemprice = tonumber(item.price) / 100
            local optionTitle = string.format("$%d | %s | Ud.: %d", tonumber(item.price), itemLabel, tonumber(item.amount))

            local subOptions = {
                title = optionTitle,
                event = 'hdrp-tarot:client:sellcount', -- change resource
                args = { name = item.name, amount = tonumber(item.amount), price = tonumber(item.price) },
                icon = itemImage,
                image = itemImage,
                arrow = true,
            }
            table.insert(sellSubMenu.options, subOptions)

        else
            if Config.Debug then print("Elemento no tiene nombre:", json.encode(item)) end
        end
    end

    lib.registerContext(sellSubMenu)
    lib.showContext('items_sell_menu')
end)

---------------
-- sell amount
---------------

RegisterNetEvent('hdrp-tarot:client:handOverMoney')
AddEventHandler('hdrp-tarot:client:handOverMoney', function()
    CreateThread(function()
        local animScene = CreateAnimScene('script@beat@town@townRobbery@handover_money', 64, 0, 0, 1)

        if Config.Debug then print('create animScene: ', animScene) end

        local pCoord = GetEntityCoords(cache.ped, 1, 0)
        pCoord = GetOffsetFromEntityInWorldCoords(cache.ped, -0.0497, 1.2016, 0.0)
        local pRot = GetEntityRotation(cache.ped, 2)
        SetAnimSceneOrigin(animScene, pCoord.x, pCoord.y, pCoord.z, pRot.x, pRot.y, pRot.z - 175.66, 2)
        SetAnimSceneEntity(animScene, "pedPlayer", cache.ped, 0)

        local objectModel = GetHashKey('P_FOLDEDBILLS01X')
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
end)

RegisterNetEvent('hdrp-tarot:client:sellcount') -- change resource
AddEventHandler('hdrp-tarot:client:sellcount', function(args)
    local maX = args.amount
    local labelX = RSGCore.Shared.Items[tostring(args.name)].label
    local input = lib.inputDialog(Lang:t('client.lang_19'), {
        {   label = Lang:t('client.lang_20').. labelX.. Lang:t('client.lang_21').. maX,
            type = 'number',
            min = 1,
            max = maX,
            required = true,
            icon = 'fa-solid fa-hashtag'
        },
    })

    if not input or not tonumber(input[1]) then lib.notify({ title = Lang:t('client.lang_22_0'), description = Lang:t('client.lang_22'), type = 'error', duration = 7000 })  return end

    local amount = tonumber(input[1])
    if amount < 1 then lib.notify({ title = Lang:t('client.lang_23'), description = Lang:t('client.lang_24'), type = 'error', duration = 7000 })  return end

    local hasItem = RSGCore.Functions.HasItem(args.name, amount)
    if not hasItem then lib.notify({ title = Lang:t('client.lang_25'), description = Lang:t('client.lang_26'), type = 'error', duration = 7000 })  return end

    TriggerServerEvent('hdrp-tarot:server:sellitem', args.name, amount, args.price) -- change resource
    
end)

RegisterNetEvent('hdrp-tarot:client:sellAll', function(sellId) -- change resource
    local input = lib.inputDialog(Lang:t('client.lang_27'), {
        {   label = Lang:t('client.lang_28'),
            type = 'select',
            options = {
                { value = 'yes', label = Lang:t('client.lang_29')},
                { value = 'no', label = Lang:t('client.lang_30')}
            },
            required = true,
            icon = 'fa-solid fa-circle-question'
        },
    })
    LocalPlayer.state:set("inv_busy", true, true)
    if not input or input[1] == 'no' then lib.notify({ title = Lang:t('client.lang_31'), description = Lang:t('client.lang_32'), type = 'error', duration = 7000 }) LocalPlayer.state:set("inv_busy", false, true) return end

    if input[1] == 'yes' then
        local items = sellId
        if type(sellId) == "table" then
            items = sellId
        end

        if lib.progressBar({
            duration = Config.SellTime,
            position = 'bottom',
            useWhileDead = false,
            canCancel = false,
            disableControl = true,
            disable = {
                move = true,
                mouse = true,
            },
            label = Lang:t('client.lang_33'),
        }) then

            TriggerServerEvent('hdrp-tarot:server:sellall', items)
            LocalPlayer.state:set("inv_busy", false, true)
        else
            lib.notify({ title = Lang:t('client.lang_34'), description = Lang:t('client.lang_35'), type = 'error', duration = 7000 })
            LocalPlayer.state:set("inv_busy", false, true)
        end
    end
end)