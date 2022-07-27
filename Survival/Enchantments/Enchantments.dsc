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
      on *_ore drops raw_* from breaking:
         - if <player.exists> and <player.item_in_hand.enchantment_types.contains_text[autosmelt]>:
            - determine passively cancelled
            - drop <context.drop_entities.get[1].item.material.name.replace_text[raw_]>_ingot <context.location> quantity:<context.drop_entities.get[1].item.quantity> speed:0.1,0
         - else:
            - stop