HC_seizure_stick:
  type: world
  debug: false
  events:
    on player right clicks entity:
      - if <player.item_in_hand.display.if_null[null]> == "Seizure Stick" and <player.is_op>:
            - rotate yaw:100000 <context.entity>

HC_dumb_dumb_stick:
  type: world
  debug: false
  events:
    on player right clicks entity:
      - if <player.item_in_hand.display.if_null[null]> == "Dumb Dumb Stick" and <player.is_op>:
        - if <context.entity.has_ai>:
            - adjust <context.entity> has_ai:false
        - if <context.entity.has_ai> != true:
            - adjust <context.entity> has_ai:true

HC_dupe:
    type: command
    usage: /Dupe
    name: Dupe
    permission: HC.admin.tools
    description: "Gives an exact copy of the held item"
    script:
        - repeat <context.args.get[1].if_null[1]>:
            - give item:<player.item_in_hand.replace_text[quantity=<player.item_in_hand.quantity>]> to:<player>

HC_rename:
    type: command
    usage: /rename
    name: rename
    tab completions:
        1: Custom Name No Spaces
    permission: HC.admin.tools
    description: "Renames the held item"
    script:
        - inventory adjust slot:hand display:<reset><context.args.get[1]>