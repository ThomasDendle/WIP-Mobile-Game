extends Node2D
@onready var AUmanager = get_tree().get_nodes_in_group("AUmanager")[0]
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var ui = get_tree().get_nodes_in_group("UI")[0]
var this_ability
var place

func _ready():
	AUmanager.removefromabilitypool("tele1") #curren abil
	AUmanager.addtoabilitypool("tele2", 8) #lvl2
	AUmanager.add_to_inventory("tele1")
	#AUmanager.remove_from_inventory("pulse1")

	#var removethis = get_node("../tele1")
	#removethis.remove()
	
	place = ui.place_button()
	$CanvasLayer/Button.position = place

func remove():
	queue_free()
	
func _on_button_pressed():
	pass 
	
	#dooooo ability stuff
	#cooldown


	#ability content goes here e.g. pulse

