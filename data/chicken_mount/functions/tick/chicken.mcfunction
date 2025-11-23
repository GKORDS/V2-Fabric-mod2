# Ensure the mount persists
data merge entity @s {PersistenceRequired:1b,DeathLootTable:"minecraft:empty"}

# Remove non-owner riders
execute as @a[distance=..0.5,nbt={RootVehicle:{Entity:{id:"minecraft:chicken"}}}] unless score @s cm_pid = @e[type=chicken,limit=1,sort=nearest,tag=cm_chicken] cm_owner run ride @s dismount

# Keep owner mounted if nearby
execute as @a[distance=..2] if score @s cm_pid = @e[type=chicken,limit=1,sort=nearest,tag=cm_chicken] cm_owner run ride @s mount @e[type=chicken,limit=1,sort=nearest,tag=cm_chicken]

# Clean up temporary tag if still present
execute if entity @s[tag=cm_new] run tag @s remove cm_new
