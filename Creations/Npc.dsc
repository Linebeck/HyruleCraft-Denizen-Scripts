HC_npc_selection_stick_script:
    type: world
    debug: false
    events:
        on player right clicks npc with:HC_npc_selection_stick:
            - ratelimit <player> 2t
            - flag <player> SelectedNpcs:|:<context.entity>
            - narrate "<green>Npc selected!"
        on player right clicks block with:HC_npc_selection_stick:
            - ratelimit <player> 2t
            - if <player.is_sneaking>:
                - flag <player> SelectedNpcs:!
                - narrate "<Green>Selected Npcs Cleared"
            - else:
                - stop

HC_british:
    type: command
    usage: /british
    name: british
    tab completions:
        1: Walk|Anchor
    permission: HC.npc.tools
    description: "Become British"
    script:
        - if <context.args.get[1]> == Walk:
            - foreach <player.flag[SelectedNpcs]>:
                - ~walk <[value]> <[value].anchor[preset]>
            - narrate <Green>Done!
        - if <context.args.get[1]> == Anchor:
            - anchor add <player.flag[SelectedNpcs].get[1]>: id:preset
            - narrate <Green>Done!