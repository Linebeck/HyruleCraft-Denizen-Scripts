HC_church_scene:
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

zc_britsh:
    type: command
    usage: /britsh
    name: britsh
    permission: HC.npc.tools
    description: "Become British"
    script:
        - foreach <player.flag[SelectedNpcs]>:
            - ~walk <[value]> <[value].anchor[preset]>
        - narrate <Green>Done!