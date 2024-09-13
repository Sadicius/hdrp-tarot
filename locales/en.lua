local Translations = {

    client = {
        lang_1 = 'To be changed to ',
        lang_2 = 'Store closed',
        lang_3 = 'Come back after ',
        lang_4 = 'am',
        lang_5 = 'Tarot shop',
        lang_6 = 'Tarot Shop',
        lang_7 = 'Sell Cards/Insigns',
        lang_8 = 'View Item List',
        lang_9 = 'Buy Badges',
        lang_10 = 'View Item List',
        lang_11 = 'opening box...',
        lang_12 = 'opening package...',
        lang_13 = 'Box is opening...',
        lang_14 = 'Box has been successfully opened...',
        -- SELL
        lang_15_0 = 'Error',
        lang_15_1 = 'No items available for sale',
        lang_15 = 'Items to sell',
        lang_16 = 'List of items to sell',
        lang_17 = 'Sell all items',
        lang_18 = 'Sell all available items',
        lang_19 = 'Do you want to sell, do you have what I need', 
        lang_20 = 'Do you have ',
        lang_21 = ' | You: ',
        lang_22_0 = 'Error',
        lang_22 = 'Please enter a valid numeric value',
        lang_23 = 'Insufficient quantity',
        lang_24 = 'The minimum quantity to be sold is 1',
        lang_25 = 'Cannot sell',
        lang_26 = 'Not enough items to sell',
        lang_27 = 'Are you sure?',
        lang_28 = 'Sell all items in the list',
        lang_29 = 'Yes',
        lang_30 = 'No',
        lang_31 = 'Sale cancelled',
        lang_32 = 'Sale cancelled',
        lang_33 = 'Negotiation...',
        lang_34 = 'Sale cancelled',
        lang_35 = 'Sale was cancelled',
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
