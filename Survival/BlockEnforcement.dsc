HC_mushroom_block_blockstate_enforcement:
    type: world
    debug: false
    events:
        on player breaks mushroom_stem|brown_mushroom_block|red_mushroom_block:
            - if <player.gamemode> != creative:
                - determine passively cancelled
                - define blockstate <context.location.material>
                - drop <context.material.name>[flag_map=[enforcedblockstate=<[blockstate]>]] <context.location>
                - modifyblock <context.location> air
        on player places block:
            - if <context.item_in_hand.has_flag[enforcedblockstate]>:
                - modifyblock <context.location> <context.item_in_hand.flag[enforcedblockstate]>