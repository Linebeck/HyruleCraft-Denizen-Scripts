# From patch_lore.dsc

patch_lore:
  type: procedure
  definitions: item|map
  debug: false
  script:
  # Generate enchantment lore
  - define lore <[map].parse_value_tag[<gray><enchantment[<[parse_key]>].full_name[<[parse_value]>].strip_color>].values>
  # Save current lore for future use
  - if !<[item].has_flag[patch_lore]>:
    - define item <[item].with_flag[patch_lore:<[item].lore.if_null[<empty>]>]>
  # Modify based on existing lore if any
  - define lore <[lore].include[<[item].flag[patch_lore]>]>
  # Adjust item mechanisms
  - define item <[item].with[hides=ENCHANTS;lore=<[lore]>]>
  # Return item
  - determine <[item]>