HC_autosmelt_enchantment:
    type: enchantment
    id: autosmelt
    debug: false
    slots:
       - mainhand
    rarity: rare
    full_name: Autosmelt
    category: DIGGER
    min_level: 1
    max_level: 1
    min_cost: 9999
    max_cost: 9999
    is_tradable: false
    is_discoverable: false

HC_autosmelt_enchantment_script:
    type: world
    debug: false
    events:
      on player breaks *_ore with:*_pickaxe:
         - if <player.item_in_hand.enchantment_types.contains[autosmelt]>:
             - determine passively cancelled
         - else:
            - stop