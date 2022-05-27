HC_midi_op_command:
    type: command
    usage: /MidiOp
    name: MidiOp
    tab completions:
        1: Play|Download|Delete
        2: <server.list_files[/midi]>
        3: Filename
    permission: HC.admin.tools
    description: "midi operations"
    script:
#play mdidi at player location
        - if <context.args.get[1]> == Play:
            - if <player.is_op>:
                - if <player.ping> >= 300:
                    - narrate "<red>Your ping is <player.ping>ms music may be garbled" targets:<player>
                - ~midi <context.args.get[2]> <player.location> volume:0.9
                - stop
            - else:
                - if <player.has_flag[musiccooldown]> != true:
                    - flag <player> musiccooldown expire:4m
                    - mark play
                    - if <player.ping> >= 300:
                        - narrate "<red>Your ping is <player.ping>ms music may be garbled" targets:<player>
                    - ~midi <context.args.get[2]> <player.location> volume:0.9
                - else:
                    - actionbar "<red>You can't player another song yet!" targets:<player>
                - stop

#Delete midi
        - if <context.args.get[1]> == Delete:
            - adjust server delete_file:midi/<context.args.get[2]>
            - narrate "<red>File deleted"
            - stop

#Download MIDI
        - if <context.args.get[1]> == Download:
            - if <context.args.get[2].if_null[null]> != null and <context.args.get[3].if_null[null]> != null:
                - ~webget <context.args.get[2]> savefile:plugins/Denizen/midi/<context.args.get[3].replace_text[.mid]>.mid save:file
                - narrate "<green>Download Complete"
                - flag <player> DownloadedMidis:|:<context.args.get[3]>
                - if <entry[file].failed>:
                    - narrate "<red>Download failed"
            - else:
                - narrate targets:<player> "<red>You must specify all values!"