
#show boat name only if it has a passenger
execute as @e[tag= is_boat] at @s if entity @p[distance=...5] run data modify entity @s CustomNameVisible set value true
execute as @e[tag= is_boat] at @s unless entity @p[distance=...5] run data modify entity @s CustomNameVisible set value false

#set the name to the correct text based on passenger's L/R_signal scores
execute as @e[tag= is_boat] at @s as @p[distance=...5] if score @s L_signal matches 0 if score @s R_signal matches 0 run data modify entity @n[tag= is_boat] CustomName set value "<§c⬜      ⬜§r>"
execute as @e[tag= is_boat] at @s as @p[distance=...5] if score @s L_signal matches 1 if score @s R_signal matches 0 run data modify entity @n[tag= is_boat] CustomName set value "<§a🟩      §c⬜§r>"
execute as @e[tag= is_boat] at @s as @p[distance=...5] if score @s L_signal matches 0 if score @s R_signal matches 1 run data modify entity @n[tag= is_boat] CustomName set value "<§c⬜      §a🟩§r>"
execute as @e[tag= is_boat] at @s as @p[distance=...5] if score @s L_signal matches 1 if score @s R_signal matches 1 run data modify entity @n[tag= is_boat] CustomName set value "<§a🟩      🟩§r>"
execute as @e[tag= is_boat] at @s unless entity @p[distance=...5] run data remove entity @s CustomName

#set default values for L/R_signal scores to 0
execute as @a unless score @s L_signal matches 0.. run scoreboard players set @s L_signal 2
execute as @a unless score @s R_signal matches 0.. run scoreboard players set @s R_signal 2
execute as @a if score @s L_signal matches 2 run scoreboard players set @s L_signal 0
execute as @a if score @s R_signal matches 2 run scoreboard players set @s R_signal 0

##change signal when player jumps
#detect current signal
execute as @e[tag= is_boat] at @s as @p[distance=...5] if score @s signalchange_cooldown matches ..1 if predicate connsboats:is_jumping if score @s L_signal matches 0 if score @s R_signal matches 0 run tag @s add signal_00
execute as @e[tag= is_boat] at @s as @p[distance=...5] if score @s signalchange_cooldown matches ..1 if predicate connsboats:is_jumping if score @s L_signal matches 1 if score @s R_signal matches 0 run tag @s add signal_10
execute as @e[tag= is_boat] at @s as @p[distance=...5] if score @s signalchange_cooldown matches ..1 if predicate connsboats:is_jumping if score @s L_signal matches 0 if score @s R_signal matches 1 run tag @s add signal_01

#switch 00 to 10
execute as @e[tag= is_boat] at @s as @p[distance=...5] if predicate connsboats:is_jumping if entity @s[tag=signal_00] run scoreboard players set @s L_signal 1
execute as @e[tag= is_boat] at @s as @p[distance=...5] if predicate connsboats:is_jumping if entity @s[tag=signal_00] run scoreboard players set @s R_signal 0

#switch 10 to 01
execute as @e[tag= is_boat] at @s as @p[distance=...5] if predicate connsboats:is_jumping if entity @s[tag=signal_10] run scoreboard players set @s L_signal 0
execute as @e[tag= is_boat] at @s as @p[distance=...5] if predicate connsboats:is_jumping if entity @s[tag=signal_10] run scoreboard players set @s R_signal 1

#switch 01 to 00
execute as @e[tag= is_boat] at @s as @p[distance=...5] if predicate connsboats:is_jumping if entity @s[tag=signal_01] run scoreboard players set @s L_signal 0
execute as @e[tag= is_boat] at @s as @p[distance=...5] if predicate connsboats:is_jumping if entity @s[tag=signal_01] run scoreboard players set @s R_signal 0

#set cooldown to 5 if they have any of the tags
scoreboard players set @a[tag=signal_00] signalchange_cooldown 5
scoreboard players set @a[tag=signal_10] signalchange_cooldown 5
scoreboard players set @a[tag=signal_01] signalchange_cooldown 5

#remove tags
tag @a remove signal_00
tag @a remove signal_10
tag @a remove signal_01

#remove from cooldown
scoreboard players remove @a signalchange_cooldown 1

#show instructions if it's their first time in a boat
execute as @e[tag= is_boat] at @s as @p[distance=...5,tag=!experienced_boater] run playsound entity.player.levelup master @s ~ ~ ~ 2 1.5
execute as @e[tag= is_boat] at @s as @p[distance=...5,tag=!experienced_boater] run tellraw @s "§aSeems like it's your first time in one of these boats! Go into F5 to see your turn signals, and press space to change what signals are activated. Safe boating!"
execute as @e[tag= is_boat] at @s as @p[distance=...5,tag=!experienced_boater] run tag @s add experienced_boater

#reset signals if not in boat
execute as @a at @s unless entity @n[tag= is_boat,distance=...5] run scoreboard players set @s L_signal 0
execute as @a at @s unless entity @n[tag= is_boat,distance=...5] run scoreboard players set @s R_signal 0

tag @e[type=#boat] add is_boat
tag @e[type=cherry_chest_boat] add is_boat
tag @e[type=oak_chest_boat] add is_boat
tag @e[type=birch_chest_boat] add is_boat
tag @e[type=acacia_chest_boat] add is_boat
tag @e[type=bamboo_chest_raft] add is_boat
tag @e[type=jungle_chest_boat] add is_boat
tag @e[type=spruce_chest_boat] add is_boat
tag @e[type=dark_oak_chest_boat] add is_boat
tag @e[type=mangrove_chest_boat] add is_boat
tag @e[type=pale_oak_chest_boat] add is_boat
