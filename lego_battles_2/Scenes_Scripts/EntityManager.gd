extends Node2D

var enemy1_scene = preload("res://Scenes_Scripts/Enemies/enemy1.tscn")
var enemy2_scene = preload("res://Scenes_Scripts/Enemies/enemy2.tscn")
var enemy3_scene = preload("res://Scenes_Scripts/Enemies/enemy3.tscn")

@onready var spawnpos1 = $SpawnPoint1
@onready var spawnpos2 = $SpawnPoint2
@onready var spawnpos3 = $SpawnPoint3
@onready var spawnpos4 = $SpawnPoint4
@onready var UI = get_tree().get_nodes_in_group("UI")[0]

var enemyType 

#This script will handle the spawning and directing of enemies. 
#It will hold all entities so it has the vector of player.


func spawn_enemy(enemyType):
	
	#Switch case here for choosing which enemy scene, 
	var enemy_instance #I hope that putting this here works, should be 
	
	match enemyType: #Godots switch case
		1:
			enemy_instance = enemy1_scene.instantiate()
			enemy_instance.position = spawnpos1.position
		2:
			enemy_instance = enemy2_scene.instantiate()
			enemy_instance.position = spawnpos2.position
		3:
			enemy_instance = enemy3_scene.instantiate()
			enemy_instance.position = spawnpos3.position
			
#I really tried to shorten this, having instaniate only called once at end, it kept not working. 

	enemy_instance.set_enemy_type(enemyType)
	enemy_instance.connect("give_money", give_value) #(name of signal, func to call)
	add_child(enemy_instance)
	
	#print("enemy " + str(enemyType) + " spawned")
	#Enemy scene gets instantiated,has its type set, then spawned
	
func give_value(value):
	#Call UI func to add gold
	#print(str(value))
	
	UI.update_money_HUD(value)

#Temp, entity manager will handle spawning of groups and waves

func _on_enemy_timer_timeout():
	spawn_enemy(1)
	
func _on_enemy_2_timer_timeout():
	spawn_enemy(2)

func _on_enemy_3_timer_timeout():
	spawn_enemy(3)
	
func _on_enemy_4_timer_timeout():
	spawn_enemy(4)
