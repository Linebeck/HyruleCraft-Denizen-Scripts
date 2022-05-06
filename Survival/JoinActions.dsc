HC_ping_warning:
    type: world
    debug: false
    events:
        on player joins:
            - wait 30s
            - if <player.ping> >= 300:
                - narrate "<red>Your ping is <player.ping>ms you may experience issues playing" targets:<player>