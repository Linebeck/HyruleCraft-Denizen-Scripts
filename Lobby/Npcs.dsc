HC_lobby_staff_npc_actions:
    type: world
    debug: false
    events:
        on player right clicks entity:
#Kumyo
            - if <context.entity.name> == Kumyo and <context.entity.entity_type> == npc:
                - ratelimit <player> 2s
                - chat talkers:<player[Kumyo]> lmao

HC_lobby_npc_actions:
    type: world
    debug: false
    events:
        on player right clicks entity:
            - if <context.entity.name> == Kumyo: