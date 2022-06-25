HC_church_scene:
    type: world
    debug: false
    events:
        on player right clicks npc with:HC_npc_selection_stick:
            - flag <player> SelectedNpcs:|:<context.entity>
            - narrate <green>"Npc slected!"
        on player right clicks block with:HC_npc_selection_stick:
            - if <player.is_sneaking>:
                - flag <player> SelectedNpcs:|:<context.entity>
                - narrate "<Green>Selected Npcs Cleared"