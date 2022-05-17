HC_subrace_vampire_script:
    type: world
    debug: false
    events:
        on system time secondly:
        #Vampire check
            - foreach <server.online_players.parse[name]>:
                - if <player[<[value]>].flag[subrace].if_null[null].contains_text[vampire]> and <player[<[value]>].gamemode> == SURVIVAL and <player[<[value]>].world.name> != c1:
                    # Burn check
                    - if <player[<[value]>].location.above.light.sky> == 15 and <player[<[value]>].world.time.period> == day and <player[<[value]>].effects_data.contains_text[FIRE_RESISTANCE]> != true:
                        - playeffect effect:SMOKE_NORMAL at:<player[<[value]>].location.above[1]> quantity:12
                        - burn <player[<[value]>]> duration:4s
                    #Fire res check
                    - if <player[<[value]>].effects_data.contains_text[FIRE_RESISTANCE]>:
                        - playeffect effect:SMOKE_NORMAL at:<player[<[value]>].location.above[1]> quantity:15
                    - cast night_vision duration:15s amplifier:-1 <player[<[value]>]> hide_particles no_icon
                    #night check
                    - if <player[<[value]>].world.time.period> == night and <player[<[value]>].can_fly> != true:
                        - adjust <player[<[value]>]> can_fly:true
                        - playsound sound:entity_bat_takeoff volume:1 pitch:-2 <player[<[value]>].location>
                    #day check
                    - if <player[<[value]>].world.time.period> == day and <player[<[value]>].can_fly> and <player[<[value]>].has_permission[essentials.fly]> != true:
                        - adjust <player[<[value]>]> can_fly:false
                        - playsound sound:entity_bat_takeoff volume:1 pitch:-2 <player[<[value]>].location>


        #Blood Drink
        on player right clicks entity:
            - if <player.flag[subrace].if_null[null].contains_text[vampire]> and <player.is_sneaking> and <context.entity.name> != item_frame and <context.entity.name> != glow_item_frame and <context.entity.name> != Armor_stand:
                - hurt <context.entity> cause:magic source:<player>
                - feed <player> amount:1 saturation:1
                - playsound <player.location> volume:0.2 sound:ENTITY_GENERIC_DRINK
                - cast regeneration duration:1s hide_particles
        #Prevent eating food
        on player consumes cooked*|Baked*:
            - if <player.flag[subrace].if_null[null].contains_text[vampire]>:
                - determine passively cancelled
        on entity death:
        #Stop death and debuff player
            - if <context.entity.flag[subrace].if_null[null].contains_text[vampire]> and <context.enity.food_level.if_null[1]> > 0 and <context.damager.item_in_hand.if_null[null].enchantment_types.parse[name].contains[smite]> != true and <context.damager.item_in_hand.script.name.if_null[null]> != HC_silver* and ( fire|fire_tick|lava|magic !contains <context.cause> ):
                - determine passively cancelled
                - adjust <context.entity> health:1
                - feed <context.entity> amount:-5
                - cast <context.entity> weakness amplifier:5 duration:15s
                - cast <context.entity> confusion duration:10s
                - playsound sound:ENTITY_BAT_HURT volume:1 pitch:-2 <context.entity.location>