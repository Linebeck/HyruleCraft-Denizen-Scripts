zc_npc_sounds:
    type: world
    debug: false
    events:
        on player right clicks npc:
            - if <context.entity.name> == morshu:
                - ratelimit <player> 8s
                - playsound custom sound:hyrulecore.characters.morshu.refuse_sale sound_category:master <context.entity.location>
                - opentrades "trade[result=blue_dye[Display=<&b>Ultra Mega Super Rare Bomb;enchantments=[luck_of_the_sea=1];hides=enchants;custom_model_data=1];inputs=netherite_block[quantity=100];max_uses=9999]|trade[result=barrier] "title:Useless Trades"""