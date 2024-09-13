local Translations = {

    client = {
        lang_1 = 'Para cambiar a ',
        lang_2 = 'Tienda cerrada',
        lang_3 = 'Volver después',
        lang_4 = 'am',
        lang_5 = 'Tienda de tarot',
        lang_6 = 'Tienda de Tarot',
        lang_7 = 'Vender Tarjetas/Insignias',
        lang_8 = 'Ver lista de elementos',
        lang_9 = 'Comprar insignias',
        lang_10 = 'Ver lista de elementos',
        lang_11 = 'abriendo cuadro...',
        lang_12 = 'abriendo paquete...',
        lang_13 = 'La caja se está abriendo...',
        lang_14 = 'La caja se ha abierto correctamente...',
        -- VENDER
        lang_15_0 = 'Error',
        lang_15_1 = 'No hay artículos disponibles para la venta',
        lang_15 = 'Artículos para vender',
        lang_16 = 'Lista de artículos para vender',
        lang_17 = 'Vender todos los artículos',
        lang_18 = 'Vender todos los artículos disponibles',
        lang_19 = '¿Quieres vender? ¿Tienes lo que necesito?',
        lang_20 = '¿Tienes',
        lang_21 = ' | Tú: ',
        lang_22_0 = 'Error',
        lang_22 = 'Ingrese un valor numérico válido',
        lang_23 = 'Cantidad insuficiente',
        lang_24 = 'La cantidad mínima a vender es 1',
        lang_25 = 'No se puede vender',
        lang_26 = 'No hay suficientes artículos para vender',
        lang_27 = '¿Estás seguro?',
        lang_28 = 'Vender todos los artículos de la lista',
        lang_29 = 'Sí',
        lang_30 = 'No',
        lang_31 = 'Venta cancelada',
        lang_32 = 'Venta cancelada',
        lang_33 = 'Negociación...',
        lang_34 = 'Venta cancelada',
        lang_35 = 'La venta fue cancelada',
    },

    server = {
        lang_1 = 'You got 4 packs!',
        lang_2 = 'You got 4 cards!',
        lang_3 = 'You dont have a pack',
        lang_4 = 'There is a problem in cards!',
        lang_5 = 'Receive',
        lang_6 = 'All cards obtained!',
        lang_7 = 'Congratulations! You have obtained all the available cards.',
        lang_8 = 'Come back when you have all the items for the ',
        lang_9 = 'Come back when you have all the items for the ',
        lang_10 = 'You got a ',
        lang_11 = 'You trade cards for ',
        lang_12 = "You do not have this card in your inventory.",
        lang_13 = 'Sell',
        lang_14 = ' | $:',
        lang_15 = 'You items to sell.',
        lang_16 = 'Total earnings | $',
        lang_17 = 'All items sold',
    },

    config = {
        lang_1 = 'Tarot Cards',
        lang_2 = 'Tarot Cards',
        lang_3 = 'Tarot Cards',
        lang_4 = 'Tarot Cards',
        lang_5 = "Rare card",
        lang_6 = "Very rare card",
        lang_7 = "Never seen letter",
        lang_8 = "Deck N1",
        lang_9 = "Deck N2",
        lang_10 = "Deck N3",
        lang_11 = "Deck N4",
        lang_12 = "Deck N5",
        lang_13 = "Big Deck",
    },

}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

-- Lang:t('client.lang_1')
-- Lang:t('server.lang_1')
-- Lang:t('config.lang_1')
