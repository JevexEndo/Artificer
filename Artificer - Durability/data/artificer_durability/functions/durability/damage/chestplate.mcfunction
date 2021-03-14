###################################################################################
#
# Author: ICY - Datapack Utilities
# Edited By: Jevex
# Description: Update chestplate durability
#
###################################################################################

# Load items into storage if not already there
execute if score $temp_7 dur.data matches 0 run function artificer_core:player_data/get_equipment
scoreboard players set $temp_7 dur.data 1

# Place chestplate into storage for data manipulation
data modify storage artificer_durability:temp object set from block -29999999 0 1601 Items[4]
execute positioned -29999999 0 1601 unless block ~ ~ ~ green_shulker_box{Items:[{Slot:4b,tag:{Durability:{Init:1b}}}]} run function artificer_durability:durability/handle/item_init
execute positioned -29999999 0 1601 if block ~ ~ ~ green_shulker_box{Items:[{Slot:4b,tag:{Durability:{Actual:0}}}]} run function artificer_durability:durability/handle/item_unbreakable
execute positioned -29999999 0 1601 unless block ~ ~ ~ green_shulker_box{Items:[{Slot:4b,tag:{Durability:{Actual:0}}}]} run function artificer_durability:durability/handle/item_durability
data modify block -29999999 0 1601 Items[4] set from storage artificer_durability:temp object

# Place offhand into storage for data manipulation
data merge block -29999999 0 1602 {Text1:'[{"translate":"item.durability","color":"#6B6B6B","italic":false,"with":[{"nbt":"Items[4].tag.Durability.Custom","block":"-29999999 0 1601","color":"#6B6B6B","italic":false},{"nbt":"Items[4].tag.Durability.CustomMax","block":"-29999999 0 1601","color":"#6B6B6B","italic":false}]}]'}
data modify block -29999999 0 1601 Items[4].tag.display.Lore[-1] set from block -29999999 0 1602 Text1

# Destroy item if broken
execute if score $out_0 dur.data matches 0 run replaceitem block -29999999 0 1601 container.4 minecraft:leather_chestplate{GUI:1b}
execute at @s if score $out_0 dur.data matches 0 run playsound minecraft:entity.item.break player @s