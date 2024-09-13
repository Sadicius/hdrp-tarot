Config = {}
Config.Debug = false
Config.img = "rsg-inventory/html/images/"

--------------
-- SETTINGS
--------------

Config.Keytrade 	= 'E'
Config.KeyShop          = 'J'
Config.UseTarget	= true -- 'true' or 'false'

Config.StoreAlwaysOpen  = true
Config.Payment          = 'money' -- can 'item' or 'money'
Config.PaymentType 		= 'cash' -- Payment = money you can select 'cash' or 'bloodmoney' / Payment = item you can select 'cash' or 'bloodmoney'

Config.SellTime         = 3000 -- time sell all
Config.OpenTime         = 6 -- hrs : 24hour clock
Config.CloseTime        = 18 -- hrs : 24hour clock

Config.FadeIn           = true -- 'true' or 'false' npc Fade In
Config.DistanceSpawn    = 20 -- number distance npc

Config.StashMaxWeight   = 500
Config.StashMaxSlots    = 81

---------
-- BUY 
---------

Config.TarotShop = {
    [1] = { name = "card_tarot",      price = 30, amount = 25,  info = {}, type = "item", slot = 1, },
    [2] = { name = "card_tarot_pack", price = 5,  amount = 100, info = {}, type = "item", slot = 2, },
    [3] = { name = "card_tarot_box",  price = 50, amount = 50,  info = {}, type = "item", slot = 3, },
}

-------------------
-- SELL ITEMS X100 (1$ = 100CTVS)
------------------

local CardsB1 = {
	["card_tarot_b6_c1"] = 50,
	["card_tarot_b6_c2"] = 50,
	["card_tarot_b6_c3"] = 50,
	["card_tarot_b6_c4"] = 50,
	["card_tarot_b6_c5"] = 50,
	["card_tarot_b6_c6"] = 50,
	["card_tarot_b6_c7"] = 50,
	["card_tarot_b6_c8"] = 50,
	["card_tarot_b6_c9"] = 50,
	["card_tarot_b6_c10"] = 50,
	["card_tarot_b6_c11"] = 50,
	["card_tarot_b6_c12"] = 50,
	["card_tarot_b6_c13"] = 50,
	["card_tarot_b6_c14"] = 50,
	["card_tarot_b6_c15"] = 50,
	["card_tarot_b6_c16"] = 50,
	["card_tarot_b6_c17"] = 50,
	["card_tarot_b6_c18"] = 50,
	["card_tarot_b6_c19"] = 50,
	["card_tarot_b6_c20"] = 50,
	["card_tarot_b6_c21"] = 50,
	["card_tarot_b6_c22"] = 50,
	["card_tarot_b6_c23"] = 50,
	["card_tarot_b6_c24"] = 50,
	["card_tarot_b6_c25"] = 50,
	["card_tarot_b6_c26"] = 50,
	["card_tarot_b6_c27"] = 50,
	["card_tarot_b6_c28"] = 50,
	["card_tarot_b6_c29"] = 50,
	["card_tarot_b6_c30"] = 50,
}

local CardsB2 = {
	["card_tarot_b6_c31"] = 75,
	["card_tarot_b6_c32"] = 75,
	["card_tarot_b6_c33"] = 75,
	["card_tarot_b6_c34"] = 75,
	["card_tarot_b6_c35"] = 75,
	["card_tarot_b6_c36"] = 75,
	["card_tarot_b6_c37"] = 75,
	["card_tarot_b6_c38"] = 75,
	["card_tarot_b6_c39"] = 75,
	["card_tarot_b6_c40"] = 75,
	["card_tarot_b6_c41"] = 75,
	["card_tarot_b6_c42"] = 75,
	["card_tarot_b6_c43"] = 75,
	["card_tarot_b6_c44"] = 75,
	["card_tarot_b6_c45"] = 75,
	["card_tarot_b6_c46"] = 75,
	["card_tarot_b6_c47"] = 75,
	["card_tarot_b6_c48"] = 75,
	["card_tarot_b6_c49"] = 75,
	["card_tarot_b6_c50"] = 75,
}

local CardsB3 = {
	["card_tarot_b6_c51"] = 100,
	["card_tarot_b6_c52"] = 100,
	["card_tarot_b6_c53"] = 100,
	["card_tarot_b6_c54"] = 100,
	["card_tarot_b6_c55"] = 100,
	["card_tarot_b6_c56"] = 100,
	["card_tarot_b6_c57"] = 100,
	["card_tarot_b6_c58"] = 100,
	["card_tarot_b6_c59"] = 100,
	["card_tarot_b6_c60"] = 100,
}

local CardsB4 = {
	["card_tarot_b6_c61"] = 200,
	["card_tarot_b6_c62"] = 200,
	["card_tarot_b6_c63"] = 200,
	["card_tarot_b6_c64"] = 200,
	["card_tarot_b6_c65"] = 200,
}

local CardsB5 = {
	["card_tarot_b6_c66"] = 250,
	["card_tarot_b6_c67"] = 250,
	["card_tarot_b6_c68"] = 250,
	["card_tarot_b6_c69"] = 250,
	["card_tarot_b6_c70"] = 250,
}

local CardsB6 = {
	["card_tarot_b6_c71"] = 500,
	["card_tarot_b6_c72"] = 500,
	["card_tarot_b6_c73"] = 500,
}

local DeckCards = {
	["card_tarot_b1"] = 1000,
	["card_tarot_b2"] = 2000,
	["card_tarot_b3"] = 2000,
	["card_tarot_b4"] = 3000,
	["card_tarot_b5"] = 4000,
	["card_tarot_b6"] = 12000,
}

Config.CardshopLocation =  {
 	{ 	id 		= 'Cardshop',
		name 		= Lang:t('config.lang_1'),
		coords 		= vector3(1309.64, -6858.61, 45.1),
		model 		= `CS_Fire_Breather`,
		coords2 	= vector4(1309.64, -6858.61, 45.1, 71.28),
		blipsprite 	= 'blip_rc',
		blipscale 	= 0.2,
		showblip 	= true,
		shopdata 	= {CardsB1, CardsB2, CardsB3, CardsB4, CardsB5, CardsB6, DeckCards}
	},
}

----------------
-- EXTRA TRADE 
----------------
Config.Badge = {
	-- CARDS ULTRA RARES
    { 	id 			= 'Cardshop5',
		Amount 		= 1,
		reward 		= "card_tarot_b6_c73",
        name 		= Lang:t('config.lang_5'),
		coords 		= vector3(-3484.76, -3467.02, 0.12),
		model 		= `cs_magnifico`,
		coords2 	= vector4(-3484.76, -3467.02, 0.12, 141.4),
		blipsprite 	= 'blip_ambient_secret',
		blipscale 	= 0.2,
		showblip 	= false,
        cards = {
			["card_tarot_b6_c1"] = 1,
			["card_tarot_b6_c2"] = 1,
			["card_tarot_b6_c3"] = 1,
			["card_tarot_b6_c4"] = 1,
			["card_tarot_b6_c5"] = 1,
			["card_tarot_b6_c41"] = 1,
			["card_tarot_b6_c42"] = 1,
			["card_tarot_b6_c46"] = 1,
			["card_tarot_b6_c55"] = 1,
		},
    },
    { 	id 			= 'Cardshop6',
		Amount 		= 1,
		reward 		= "card_tarot_b6_c72",
        name 		= Lang:t('config.lang_6'),
		coords 		= vector3(2318.86, 983.13, 75.51),
		model 		= `cs_mp_travellingsaleswoman`,
		coords2 	= vector4(2318.86, 983.13, 75.51, 170.25),
		blipsprite 	= 'blip_ambient_secret',
		blipscale 	= 0.2,
		showblip 	= false,
        cards = {
			["card_tarot_b6_c6"] = 1,
			["card_tarot_b6_c7"] = 1,
			["card_tarot_b6_c8"] = 1,
			["card_tarot_b6_c9"] = 1,
			["card_tarot_b6_c10"] = 1,
			["card_tarot_b6_c44"] = 1,
			["card_tarot_b6_c43"] = 1,
			["card_tarot_b6_c47"] = 1,
			["card_tarot_b6_c56"] = 1,
		},
    },
    {   id 			= 'Cardshop7',
		Amount 		= 1,
		reward 		= "card_tarot_b6_c71",
        name 		= Lang:t('config.lang_7'),
		coords 		= vector3(1182.39, 2035.27, 323.91),
		model 		= `cs_mp_teddybrown`,
		coords2 	= vector4(1182.39, 2035.27, 323.91, 141.4),
		blipsprite 	= 'blip_ambient_secret',
		blipscale 	= 0.2,
		showblip 	= false,
        cards = {
			["card_tarot_b6_c11"] = 1,
			["card_tarot_b6_c12"] = 1,
			["card_tarot_b6_c13"] = 1,
			["card_tarot_b6_c14"] = 1,
			["card_tarot_b6_c15"] = 1,
			["card_tarot_b6_c45"] = 1,
			["card_tarot_b6_c48"] = 1,
			["card_tarot_b6_c54"] = 1,
			["card_tarot_b6_c57"] = 1,
		},
    },
	-- DECK CARDS
    { 	id 			= 'Cardshop8',
		Amount 		= 1,
		reward 		= "card_tarot_b1",
        name 		= Lang:t('config.lang_8'),
		coords 		= vector3(631.92, -1251.45, 41.55),
		model 		= `re_rally_males_01`,
		coords2 	= vector4(631.92, -1251.45, 41.55, 293.07),
		blipsprite 	= 'blip_ambient_secret',
		blipscale 	= 0.2,
		showblip 	= false,
        cards = {
			["card_tarot_b6_c16"] = 1,
			["card_tarot_b6_c17"] = 1,
			["card_tarot_b6_c18"] = 1,
			["card_tarot_b6_c19"] = 1,
			["card_tarot_b6_c20"] = 1,
			["card_tarot_b6_c49"] = 1,
			["card_tarot_b6_c58"] = 1,
		},
    },
    { 	id 			= 'Cardshop9',
		Amount 		= 1,
		reward 		= "card_tarot_b2",
        name 		= Lang:t('config.lang_9'),
		coords 		= vector3(-156.34, 1488.86, 116.11),
		model 		= `re_deadjohn_males_01`,
		coords2 	= vector4(-156.34, 1488.86, 116.11, 141.4),
		blipsprite 	= 'blip_ambient_secret',
		blipscale 	= 0.2,
		showblip 	= false,
        cards = {
			["card_tarot_b6_c21"] = 1,
			["card_tarot_b6_c22"] = 1,
			["card_tarot_b6_c23"] = 1,
			["card_tarot_b6_c24"] = 1,
			["card_tarot_b6_c25"] = 1,
			["card_tarot_b6_c50"] = 1,
			["card_tarot_b6_c59"] = 1,
		},
    },
    { 	id 			= 'Cardshop10',
		Amount 		= 1,
		reward 		= "card_tarot_b3",
        name 		= Lang:t('config.lang_10'),
		coords 		= vector3(-1403.78, -2330.28, 43.04),
		model 		= `a_m_y_sdstreetkids_slums_02`,
		coords2 	= vector4(-1403.78, -2330.28, 43.04, 293.07),
		blipsprite 	= 'blip_ambient_secret',
		blipscale 	= 0.2,
		showblip 	= false,
        cards = {
			["card_tarot_b6_c26"] = 1,
			["card_tarot_b6_c27"] = 1,
			["card_tarot_b6_c28"] = 1,
			["card_tarot_b6_c29"] = 1,
			["card_tarot_b6_c30"] = 1,
			["card_tarot_b6_c51"] = 1,
			["card_tarot_b6_c60"] = 1,
		},
    },
    { 	id 			= 'Cardshop11',
		Amount 		= 1,
		reward 		= "card_tarot_b4",
        name 		= Lang:t('config.lang_11'),
		coords 		= vector3(-2812.96, -4395.96, -17.18),
		model 		= `a_m_y_nbxstreetkids_01`,
		coords2 	= vector4(-2812.96, -4395.96, -17.18, 141.4),
		blipsprite 	= 'blip_ambient_secret',
		blipscale	= 0.2,
		showblip 	= false,
        cards = {
			["card_tarot_b6_c31"] = 1,
			["card_tarot_b6_c32"] = 1,
			["card_tarot_b6_c33"] = 1,
			["card_tarot_b6_c34"] = 1,
			["card_tarot_b6_c35"] = 1,
			["card_tarot_b6_c52"] = 1,
		},
    },
    { 	id 			= 'Cardshop12',
		Amount 		= 1,
		reward 		= "card_tarot_b5",
        name 		= Lang:t('config.lang_12'),
		coords 		= vector3(353.83, -17.12, 107.1),
		model		= `a_m_y_nbxstreetkids_slums_01`,
		coords2 	= vector4(353.83, -17.12, 107.1, 293.07),
		blipsprite 	= 'blip_ambient_secret',
		blipscale 	= 0.2,
		showblip 	= false,
        cards = {
			["card_tarot_b6_c36"] = 1,
			["card_tarot_b6_c37"] = 1,
			["card_tarot_b6_c38"] = 1,
			["card_tarot_b6_c39"] = 1,
			["card_tarot_b6_c40"] = 1,
			["card_tarot_b6_c53"] = 1,
		},
    },
	-- BIG DECK CARD
    { 	id 			= 'Cardshop13',
		Amount 		= 1,
		reward 		= "card_tarot_b6",
        name 		= Lang:t('config.lang_13'),
		coords 		= vector3(1203.24, -7108.66, 43.58),
		model 		= `CS_Fire_Breather`,
		coords2 	= vector4(1203.24, -7108.66, 43.58, 293.07),
		blipsprite 	= 'blip_ambient_secret',
		blipscale 	= 0.2,
		showblip 	= false,
        cards = {
			["card_tarot_b1"] = 1,
			["card_tarot_b2"] = 1,
			["card_tarot_b3"] = 1,
			["card_tarot_b4"] = 1,
			["card_tarot_b5"] = 1,
		}
    },
}

-------------------------
-- EXTRA Webhooks / RANKING
-----------------------
Config.Webhooks = {
	["tarotcards"] 	= "",
    ["trader"] 		= "",
}
