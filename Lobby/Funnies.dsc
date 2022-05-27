zc_funnies:
    type: world
    debug: false
    events:
        on player right clicks player:
            - if <context.entity.is_op>:
                - ratelimit <player> 30s
                - random:
                    - playsound custom sound:hyrulecore.music.instruments.ocarina.oot.sarias_song <context.location> volume:1
                    - playsound custom sound:hyrulecore.music.instruments.ocarina.oot.song_of_storms <context.location> volume:1
                    - playsound custom sound:hyrulecore.music.instruments.ocarina.oot.zeldas_lullaby <context.location> volume:1
                    - playsound custom sound:hyrulecore.music.instruments.ocarina.oot.suns_song <context.location> volume:1
                    - playsound custom sound:hyrulecore.music.instruments.ocarina.oot.eponas_song <context.location> volume:1


