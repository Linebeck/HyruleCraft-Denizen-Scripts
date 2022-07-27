HC_TNT_doesnt_explode:
    type: world
    debug: false
    events:
        after tnt primes:
            - if <context.entity.world.name> == creative:
                - remove <context.entity>
                - narrate "<red>TNT is disabled in this world!!""