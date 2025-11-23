# Ensure player has a persistent personal ID
execute unless score @s cm_pid matches 1.. run scoreboard players random @s cm_pid 100000 999999999

# Copy caller id to a temp holder
scoreboard players operation #caller cm_temp = @s cm_pid

# Remove existing mount owned by caller
execute as @e[type=minecraft:chicken,tag=cm_chicken] if score @s cm_owner = #caller cm_temp run kill @s

# Summon the new chicken mount just in front of the caller
summon minecraft:chicken ^ ^ ^1 {Tags:["cm_chicken","cm_new"],PersistenceRequired:1b,DeathLootTable:"minecraft:empty",CustomName:'{"text":"Chicken Mount","color":"gold","italic":false}',Attributes:[{Name:"minecraft:generic.max_health",Base:40.0},{Name:"minecraft:generic.movement_speed",Base:0.35},{Name:"minecraft:generic.knockback_resistance",Base:0.1}],Health:40.0f}

# Bind ownership to the caller
execute as @e[type=minecraft:chicken,tag=cm_new,limit=1,sort=nearest] run scoreboard players operation @s cm_owner = #caller cm_temp

tag @e[type=minecraft:chicken,tag=cm_new,limit=1,sort=nearest] remove cm_new

# Mount the caller onto the new chicken
ride @s mount @e[type=minecraft:chicken,tag=cm_chicken,limit=1,sort=nearest]
