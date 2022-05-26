HC_shop_confirm_V2_menu:
    type: inventory
    inventory: chest
    title: <red><bold>Confirm Purchase <green>V2
    gui: true
    slots:
        - [] [] [] [] [<[PlayerMoneyItem]>] [] [] [] []
        - [] [HC_shop_virtual_math_remove_item[display=-32]] [HC_shop_virtual_math_remove_item[display=-16]] [HC_shop_virtual_math_remove_item[display=-1]] [<[BuyItem]>] [HC_shop_virtual_math_add_item[display=+1]] [HC_shop_virtual_math_add_item[display=+16]] [HC_shop_virtual_math_add_item[display=+32]] []
        - [] [] [] [] [HC_shop_virtual_cancel_item] [] [] [] []

HC_shop_V2_menu:
    type: inventory
    inventory: chest
    title: <reset><dark_gray>Test
    gui: true
    slots:
        - [diamond[display=<green>Buy Me!;lore=<green>Left Click Buy:<red> $10]] [] [] [] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []

HC_shop_V2_menu_script:
    type: world
    debug: false
    events:
        on player clicks item in HC_shop_*:
    #Detect player selection
    #Create virtual item for menu
            - if <context.item.lore.contains_text[buy:]>:
                - define BuyItem <context.item>
                - define PlayerMoneyItem "player_head[skull_skin=<player.uuid>;display=<player.name>;lore=<reset><gold>Money: <reset><white>$<player.money.as_money.format_number.if_null[0]>]"
                - flag <player> lastshopmenu:<player.open_inventory.script.name>
                - flag <player> buying:<reset><[BuyItem]>
                - flag <player> buyingamount:1
                - inventory open d:HC_shop_confirm_V2_menu
        on player clicks HC_shop_virtual_* in HC_shop_confirm_V2_menu:
    #Detect cancel
            - if <context.item.script.name.if_null[null]> == HC_shop_virtual_cancel_item:
                - inventory open d:<player.flag[lastshopmenu]>
    #Detect amount
            - if <context.item.script.name> == HC_shop_virtual_math_*:
              - if <context.item.display.contains_text[+]>:
                - ratelimit <player> 1t
                - if <player.flag[buyingamount]> >= 0:
                  - flag <player> buyingamount:<player.flag[buyingamount].if_null[1].add[<context.item.display.strip_color.replace_text[+]>]>
                - actionbar <blue>Buying:<reset><player.flag[buyingamount]>
                - stop
              - else:
                - ratelimit <player> 1t
                - if <player.flag[buyingamount]> >= 64:
                  - flag <player> buyingamount:<player.flag[buyingamount].if_null[1].sub[<context.item.display.strip_color.replace_text[-]>]>
                - actionbar <blue>Buying:<reset><player.flag[buyingamount]>
                - stop
#virtual items for menus
HC_shop_virtual_cancel_item:
  type: item
  debug: false
  material: Barrier
  flags:
    Amount: 1
    uuid: <util.random_uuid>
  display name: <reset><red>Cancel

HC_shop_virtual_math_add_item:
  type: item
  debug: false
  material: blue_stained_glass_pane
  flags:
    uuid: <util.random_uuid>
    amount: 1
  display name: <reset><red>NULL REPORT TO ADMIN
  mechanisms:
    hides:
      - ENCHANTS
  enchantments:
    - luck: 4

HC_shop_virtual_math_remove_item:
  type: item
  debug: false
  material: red_stained_glass_pane
  flags:
    uuid: <util.random_uuid>
    amount: 1
  display name: <reset><red>NULL REPORT TO ADMIN
  mechanisms:
    hides:
      - ENCHANTS
  enchantments:
    - luck: 4
