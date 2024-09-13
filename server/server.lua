local RSGCore = exports['rsg-core']:GetCoreObject()

--------------------
-- send To Discord
-------------------

local function sendToDiscord(color, name, message, footer, type)
    local embed = {{
        ["color"] = color,
        ["title"] = "**".. name .."**",
        ["description"] = message,
        ["footer"] = {
            ["text"] = footer
        }
    }}
    if type == "trader" then
        PerformHttpRequest(Config['Webhooks']['trader'], function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
    elseif type == "tarot" then
        PerformHttpRequest(Config['Webhooks']["tarotcards"], function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
    end
end

---------
-- CARDS
---------

local basicCards = {
    "card_tarot_b6_c1",
    "card_tarot_b6_c2",
    "card_tarot_b6_c3",
    "card_tarot_b6_c4",
    "card_tarot_b6_c5",
    "card_tarot_b6_c6",
    "card_tarot_b6_c7",
    "card_tarot_b6_c8",
    "card_tarot_b6_c9",
    "card_tarot_b6_c10",
    "card_tarot_b6_c11",
    "card_tarot_b6_c12",
    "card_tarot_b6_c13",
    "card_tarot_b6_c14",
    "card_tarot_b6_c15",
    "card_tarot_b6_c16",
    "card_tarot_b6_c17",
    "card_tarot_b6_c18",
    "card_tarot_b6_c19",
    "card_tarot_b6_c20",
    "card_tarot_b6_c21",
    "card_tarot_b6_c22",
    "card_tarot_b6_c23",
    "card_tarot_b6_c24",
    "card_tarot_b6_c25",
    "card_tarot_b6_c26",
    "card_tarot_b6_c27",
    "card_tarot_b6_c28",
    "card_tarot_b6_c29",
    "card_tarot_b6_c30",
}

local rareCards = {
    "card_tarot_b6_c31",
    "card_tarot_b6_c32",
    "card_tarot_b6_c33",
    "card_tarot_b6_c34",
    "card_tarot_b6_c35",
    "card_tarot_b6_c36",
    "card_tarot_b6_c37",
    "card_tarot_b6_c38",
    "card_tarot_b6_c39",
    "card_tarot_b6_c40",
    "card_tarot_b6_c41",
    "card_tarot_b6_c42",
    "card_tarot_b6_c43",
    "card_tarot_b6_c44",
    "card_tarot_b6_c45",
    "card_tarot_b6_c46",
    "card_tarot_b6_c47",
    "card_tarot_b6_c48",
    "card_tarot_b6_c49",
    "card_tarot_b6_c50",
}

local ultraCards = {
    "card_tarot_b6_c51",
    "card_tarot_b6_c52",
    "card_tarot_b6_c53",
    "card_tarot_b6_c54",
    "card_tarot_b6_c55",
    "card_tarot_b6_c56",
    "card_tarot_b6_c58",
    "card_tarot_b6_c57",
    "card_tarot_b6_c59",
    "card_tarot_b6_c60",
}

local vCards = {
    "card_tarot_b6_c61",
    "card_tarot_b6_c62",
    "card_tarot_b6_c63",
    "card_tarot_b6_c64",
    "card_tarot_b6_c65",
    "card_tarot_b6_c66",
    "card_tarot_b6_c67",
    "card_tarot_b6_c68",
    "card_tarot_b6_c69",
    "card_tarot_b6_c70",
}

local vmaxCards = {
    "card_tarot_b6_c71",
    "card_tarot_b6_c72",
    "card_tarot_b6_c73",
}

local rainbowCards = {
    "card_tarot_b1",
    "card_tarot_b2",
    "card_tarot_b3",
    "card_tarot_b4",
    "card_tarot_b5",
}

-----------------
-- USEABLE ITEMS
-----------------

RSGCore.Functions.CreateUseableItem("card_tarot", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item.name, 1, item.slot, item.info)
	TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item.name], "remove")

    if item ~= nil then
        Wait(100)
        TriggerClientEvent("Cards2:Client:OpenCards", src, item.name)
	    Player.Functions.AddItem('card_tarot_pack', 4)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['card_tarot_pack'], "add")
        Wait(4000)
        TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_1'), type = 'inform', duration = 5000 })
        Wait(1000)
    end
end)

RSGCore.Functions.CreateUseableItem("card_tarot_pack", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent("Cards2:Client:OpenPack", src)
    Wait(4000)
    TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_2'), type = 'inform', duration = 5000 })
end)

RSGCore.Functions.CreateUseableItem("card_tarot_box", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    TriggerClientEvent("Cards2:client:UseBox", src)
    sendToDiscord(16753920,	"Tarot | BOX", "Player Opened The Box **".. "\n**Citizenid:** "..Player.PlayerData.citizenid.."\n**Ingame ID:** "..Player.PlayerData.cid.. "\n**Name:** "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.. "**",	"Tarot for RSG Framework", "tarot")
end)

----------------
-- REMOVE ITEM
----------------

RegisterServerEvent('Cards2:Server:RemoveItem')
AddEventHandler('Cards2:Server:RemoveItem', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local pack = Player.Functions.GetItemByName("card_tarot_pack")
    if pack.amount == nil then
        TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_3'), type = 'error', duration = 5000 })
    else
        Player.Functions.RemoveItem('card_tarot_pack', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['card_tarot_pack'], "remove")
    end
end)

-----------
-- RANDOM
-----------

CreateThread(function()
    math.randomseed(os.time())
end)

------------------------
-- ITEM FOR ADD REWARD
------------------------

RegisterServerEvent('Cards2:Server:rewarditem')
AddEventHandler('Cards2:Server:rewarditem', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local card = ''

    local randomChance = math.random(1, 1000)
    if Config.Debug then print('if you wanna see the random chance'.. randomChance) end
    if randomChance <= 5 then
        card = rainbowCards[math.random(1,#rainbowCards)]
	elseif randomChance >= 6 and randomChance <= 19 then
        card = vmaxCards[math.random(1, #vmaxCards)]
	elseif randomChance >= 20 and randomChance <= 50 then
        card = vCards[math.random(1, #vCards)]
	elseif randomChance >= 51 and randomChance <= 100 then
        card = ultraCards[math.random(1, #ultraCards)]
    elseif randomChance >= 101 and randomChance <= 399 then
        card = rareCards[math.random(1, #rareCards)]
    else
        card = basicCards[math.random(1, #basicCards)]
	end

    Wait(10)
    if Config.Debug then print(card) end
    if card ~= '' then
        TriggerClientEvent('Cards2:Client:CardChoosed', src, card)
    else
        TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_4'), type = 'error', duration = 5000 })
    end
end)

---------------
-- COUNT CARDS
---------------

local cardsObtained = {} -- Define una tabla para almacenar las cartas y barajas obtenidas por el jugador

local function checkAllCardsAndDecksObtained(playerId)
    if playerId then
        local allCardsObtained = true
        local allCards = {basicCards, rareCards, ultraCards, vCards, vmaxCards} --, rainbowCards
        local playerObtainedCards = cardsObtained[playerId]

        if playerObtainedCards then
            for _, cardList in ipairs(allCards) do
                for _, cardName in ipairs(cardList) do
                    if not playerObtainedCards[cardName] then
                        allCardsObtained = false
                        break
                    end
                end
                if not allCardsObtained then
                    break
                end
            end
        else
            allCardsObtained = false
        end
        return allCardsObtained
    else
        return false
    end
end

---------------------
-- ADD RANDOM REWARD
---------------------

RegisterServerEvent('Cards2:Server:GetTarot')
AddEventHandler('Cards2:Server:GetTarot', function(tarot)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    if tarot ~= nil then
        Player.Functions.AddItem(tarot, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[tarot], "add")

        TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_5').. "1 x "..RSGCore.Shared.Items[tarot].label, type = 'inform', duration = 5000 })
        sendToDiscord(16753920,	"Loot Tarot | REWARDS ", "Player Opened The cards".."\nCitizenid:** "..Player.PlayerData.citizenid.."\n** Ingame ID:** "..Player.PlayerData.cid.. "\n**Name:** "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.. '\n** Rewards Cards: **'.. "1 x "..RSGCore.Shared.Items[tarot].label.. "**", "Tarot for RSG Framework", "tarot")

        local citizenid = Player.PlayerData.citizenid
        cardsObtained[tarot] = true
        local allCardsObtained = checkAllCardsAndDecksObtained(citizenid)

        if allCardsObtained then
            TriggerClientEvent('ox_lib:notify', src, { title = Lang:t('server.lang_6'),  description = Lang:t('server.lang_7'), type = 'inform', icon = 'fa-solid fa-check-circle', duration = 7000 })
            sendToDiscord(16753920,	"Tarot | BOX", "\nCitizenid:** "..Player.PlayerData.citizenid.."\n** Ingame ID:** "..Player.PlayerData.cid.. "\n** Name:** "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.. '\n**HA CONSEGUIDO TODAS LAS CARTAS',	"Tarot for RSG Framework", "tarot")
        end
    end
end)

AddEventHandler('rsg-core:server:PlayerLoaded', function(playerId, cards)
    cardsObtained[playerId] = {}
    for _, card in ipairs(cards) do
        cardsObtained[playerId][card] = false
    end
end)

-----------------------
-- TRADE CARDS FOR BAG
-----------------------

RegisterServerEvent("Cards2:server:badges")
AddEventHandler("Cards2:server:badges", function(id)
local total = 0
local canBadge = true
local src = source
local Player = RSGCore.Functions.GetPlayer(src)

    for _, v in pairs(Config.Badge) do
        if v.id == id then
            for k, v2 in pairs(v.cards) do
                if Player.Functions.GetItemByName(k) ~= nil then
                    if Player.Functions.GetItemByName(k).amount < v2 then
                        canBadge = false
                        TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_8')..RSGCore.Shared.Items[k].label, type = 'error', duration = 5000 })
                    end
                else
                    canBadge = false
                    TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_9')..RSGCore.Shared.Items[k].label, type = 'error', duration = 5000 })
                    break
                end
            end
        end
    end

    if canBadge then

        for k, v in pairs(Config.Badge) do
            if v.id == id then
                TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_10')..v.name, type = 'inform', duration = 5000 })
                for k2, v2 in pairs(v.cards) do
                    Player.Functions.RemoveItem(k2, v2)
                    TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[k2], "remove")
                end

                Wait(2000)
                Player.Functions.AddItem(v.reward, v.Amount)
                TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[v.reward], "add")

                TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_11')..RSGCore.Shared.Items[v.reward]["label"], type = 'error', duration = 5000 })
                sendToDiscord(16753920,	"Loot Tarot | TRADE REWARDS ", "Player Opened The cards".."\n Citizenid:** "..Player.PlayerData.citizenid.."\n** Ingame ID:** "..Player.PlayerData.cid.. "\n** Name:** "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.. '\n**Rewards Cards: **'.. 'You trade cards for '..RSGCore.Shared.Items[v.reward].label.. "**", "Tarot for RSG Framework", "tarot")
            end
        end
    end
end)

--------------
-- MOVE CARDS
--------------
local function createCardUsableItems(cards)
    for _, cardName in ipairs(cards) do
        RSGCore.Functions.CreateUseableItem(cardName, function(source, item)
            local src = source
            local Player = RSGCore.Functions.GetPlayer(src)
            if item then
                local cardImagePath = "./img/" .. cardName .. ".png"  -- Ruta de la imagen de la carta
                TriggerClientEvent("hdrp-tarot:Client:OpenCardsIndivudal", src, cardImagePath)
            else
                TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_12'), type = 'inform', duration = 5000 })
            end
        end)
    end
end

createCardUsableItems(basicCards)
createCardUsableItems(rareCards)
createCardUsableItems(ultraCards)
createCardUsableItems(vCards)
createCardUsableItems(vmaxCards)
createCardUsableItems(rainbowCards)