zc_npc_sounds:
    type: world
    debug: false
    events:
        on player right clicks npc:
            - if <context.entiy.name> == morshu:
                - ratelimit <player> 5s
                - playsound custom sound:hyrulecore.characters.morshu.refuse_sale sound_category:master <context.entity.location>
