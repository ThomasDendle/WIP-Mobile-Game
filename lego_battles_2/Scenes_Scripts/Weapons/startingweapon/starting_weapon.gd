extends Node2D

var starting_weapon_bullets = preload("res://Scenes_Scripts/Weapons/startingweapon/starting_weapon_bullets.tscn")
var target_velocity = Vector2()
var target_position
var enemy_position 
@export var projectile_speed = 200
@export var dmg = 10
@onready var starting_position = get_tree().get_nodes_in_group("player")[0]
@onready var firerate = $Firerate #Adjusted in weapon scenes
signal shoot(bullet)

func _on_area_2d_body_entered(body):
	
	#Enemy enters weapon range
	enemy_position = body.position
	firerate.start()

func _on_firerate_timeout():
	
	#Using timers since all weapons are automatically fired
	var starting_weapon_bullets_scene = starting_weapon_bullets.instantiate()
	target_position = (enemy_position - starting_position.position).normalized() #still mind blowing
	target_velocity = target_position * projectile_speed
	starting_weapon_bullets_scene.give_velocity(target_velocity)
	starting_weapon_bullets_scene.give_bullet_type(0) #Hard-
	shoot.emit(starting_weapon_bullets_scene)
	#Everything to do with the weapon firing goes in here.

func _on_area_2d_body_exited(body):
	firerate.stop()
