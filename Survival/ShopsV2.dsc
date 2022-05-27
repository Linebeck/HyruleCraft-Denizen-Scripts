HC_confirm_shop_V2_menu:
    type: inventory
    inventory: chest
    title: <red><bold>Confirm Purchase
    gui: true
    slots:
        - [] [] [] [] [<[PlayerMoneyItem]>] [] [] [] []
        - [] [HC_shop_virtual_math_remove_item[display=-32]] [HC_shop_virtual_math_remove_item[display=-16]] [HC_shop_virtual_math_remove_item[display=-1]] [<[BuyItem]>] [HC_shop_virtual_math_add_item[display=+1]] [HC_shop_virtual_math_add_item[display=+16]] [HC_shop_virtual_math_add_item[display=+32]] []
        - [] [] [] [] [HC_shop_virtual_cancel_item] [] [] [] []

HC_shop_V2_menu:
    type: inventory
    inventory: chest
    title: <reset><bold><green>Test Shop Menu
    gui: true
    slots:
        - [diamond[lore=<green>Left Click Buy:<red> $1;flag_map=[item=diamond]]] [] [] [] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []

HC_shop_V2_menu_script:
    type: world
    debug: false
    events:
        on player clicks item in HC_shop_*:
    #Create virtual item for menu
            - if <context.item.lore.contains_text[buy:]>:
                - define BuyItem <context.item>
                - define PlayerMoneyItem "player_head[skull_skin=<player.uuid>;display=<player.name>;lore=<reset><gold>Money: <reset><white>$<player.money.as_money.format_number.if_null[0]>]"
                - flag <player> lastshopmenu:<player.open_inventory.script.name>
                - flag <player> buying:<reset><[BuyItem]>
                - flag <player> buyingamount:1
                - inventory open d:HC_confirm_shop_V2_menu
        on player clicks HC_shop_virtual_* in HC_confirm_shop_V2_menu:
    #Detect cancel
            - if <context.item.script.name.if_null[null]> == HC_shop_virtual_cancel_item:
                - inventory open d:<player.flag[lastshopmenu]>
    #Detect amount
            - if <context.item.display.contains_text[+]>:
              - ratelimit <player> 1t
              - flag <player> buyingamount:<player.flag[buyingamount].if_null[1].add[<context.item.display.strip_color.replace_text[+]>]>
              - define price <context.item.lore.strip_color.after[$].replace_text[|].mul[<player.flag[buyingamount]>]>
              - actionbar "<blue>Buying<reset>: <player.flag[buyingamount]> <blue>Price<reset>: $<[price]>"
              - stop
            - if <context.item.display.contains_text[-]>:
              - ratelimit <player> 1t
              - if <player.flag[buyingamount]> >= <context.item.display.strip_color.replace_text[-].add[1]>:
                - flag <player> buyingamount:<player.flag[buyingamount].if_null[1].sub[<context.item.display.strip_color.replace_text[-]>]>
              - else:
                - flag <player> buyingamount:1
                - define price <context.item.lore.strip_color.after[$].replace_text[|].mul[<player.flag[buyingamount]>]>
              - actionbar "<blue>Buying<reset>: <player.flag[buyingamount]> <blue>Price<reset>: $<[price]>"
              - stop
    #Money calc
        on player clicks item in HC_confirm_shop_V2_menu:
            - define playermoneyformated <player.money.as_money.format_number.if_null[0]>
            - define price <context.item.lore.strip_color.after[$].replace_text[|].mul[<player.flag[buyingamount]>]>
            - if <context.item.lore.contains_text[buy:]>:
              - ratelimit <player> 5t
              - if <player.flag[buyingamount]> <= <player.inventory.can_fit[<context.item>].count>:
                - if <player.money> >= <[price]>:
                  - money take <[price]>
                  - if <context.item.flag[item].if_null[self]> == self:
                    - define item <context.item.replace_text[<context.item.lore.get[1]>]>
                  - else:
                    - define item <context.item.flag[item]>
                  - give <[item]> quantity:<player.flag[buyingamount]>
                  - narrate "<&b>You bought <reset><player.flag[buyingamount]> <&b>of <reset><context.item.flag[item].as_item.display.if_null[<context.item.flag[item].as_item.material.name>]>!"
                - else:
                  - narrate "<red>You have insufficient funds! <green>You need<reset> $<[price].sub[<[playermoneyformated]>].as_money.format_number> <green>More"
              - else:
                - narrate "<red>You have insufficient inventory space!"

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
