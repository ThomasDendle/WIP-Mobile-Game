extends Node2D

#vars
var current_mouse_pos

#preloading all our buildings
var arctower_scene = preload("res://Scenes_Scripts/Buildings/arctower.tscn")


#preloading all our guns
var starting_weapon_scene = preload("res://Scenes_Scripts/Weapons/startingweapon/starting_weapon.tscn")

#onreadys
@onready var ui = $UI
@onready var money_HUD = $UI/HUD/Money 
@onready var health_HUD = $UI/HUD/Health
@onready var player = $Player
@onready var weapon_holder = $Player/WeaponHolder #without this it doesnt spawn on player.
@onready var AUmanager = $AbilUpManager


	
func _ready():
	
	setup_player()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

###PLAYER#######################################################################	

func setup_player():
	
	if Global.character_selected == null:	#remember to take this out
		Global.character_selected = 0
		
		
	print("setting up player : " + str(Global.character_selected))
	match Global.character_selected:
		0:
			on_weapon_pickup(0)			#Default player, default starting gun
			#add_starting_ability(0)
			#add_starting_upgrade(0)	#default player starts with no ups or abs
			player.finish_setup(0)		#To adjust speed/health/bonuses, etc
		1:
			pass
			#special charcters stuff here


func _shoot(bullet):
	add_child(bullet)
	bullet.position = $Player.position #oops almost forgot this
	#print(str(bullet))
	#print("shooting")

###PICKUPS######################################################################

func on_weapon_pickup(weapon_no):
	
	if weapon_no == 0:
		var starting_weapon_instance = starting_weapon_scene.instantiate()
		weapon_holder.add_child(starting_weapon_instance)
		#starting_weapon_instance.position = weapon_holder.position
		
		starting_weapon_instance.connect("shoot", _shoot) #(name of signal, func to call)
		#Very important. Once weapon is in scene, connect its signals.
		
	else:
		print("no guns baws")
	
	#will replace with match + addgunX()
	print("Weapon " + str(weapon_no) + " activated!")
	
	#give player a new weapon

func add_starting_ability(ability):
	
	#TODO abilities to be given on spawn, used for special characters
	#AUmanager.give_ability(ability)
	#AUmanager.removefromabilitypool()
	#AUmanager.addtoabilitypool()
	
	pass
	#ui.ability_list(ability_no)
	
	#print("Ability " + str(ability_no) + " activated!")

func add_starting_upgrade(upgrade):
	
	pass
	#AUmanager.give_upgrade(upgrade)
	#AUmanager.removefromupgradepool()
	#AUmanager.addtoupgradepool()
	#give player starting upgrade here. for special characters
#print("Upgrade " + str(upgrade_no) + " activated!")

###BUILDINGS####################################################################

func _on_ui_spawn_building(selected_building):
	
	print(str(selected_building))
	
	current_mouse_pos = get_global_mouse_position()
	#Getting mouse pos for where to spawn buildings
	
	var arctower_instance = arctower_scene.instantiate()
	arctower_instance.global_position = current_mouse_pos
	add_child(arctower_instance)
	
	#money = -10 #got to make this func only happen once per second, or not happen when mouse over placed building
	ui.update_money_HUD(-10) #TODO replace with ArcCost Var, every building will have one
	
	
	#Need to make it so whatever building selected picks the right scene, maybe a switch statement, but this works! YIPPEE!



