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
                - flag <player> SelectedNpcs:|:<context.entity>
                - narrate "<Green>Selected Npcs Cleared"
            - else:
                - stop