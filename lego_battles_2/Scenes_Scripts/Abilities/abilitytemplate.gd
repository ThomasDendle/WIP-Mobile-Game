extends Node2D
@onready var AUmanager = get_tree().get_nodes_in_group("AUmanager")[0]
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var ui = get_tree().get_nodes_in_group("UI")[0]

#Collect drone, be presnted either upgrade or ability in UI
#UI adds childs that displays the prompt, player can add if space, replace or cash
#if slots full, prompt from ui to choose ability to replace, remove replaced, add new
#if a level2, remove level 1 and replace with level 2

var this_ability
var place

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Remove the ability given from the pool so you cant get it again
	AUmanager.removefromabilitypool("current abil") 
	#Add the next level ability to the pool so it can be got
	AUmanager.addtoabilitypool("next abil", 0) #lvl2
	
	#Joy of joys, I also have to do this here. Because the .erase function just doesnt work in aumanager.
	#It works for the ability pool dict, but not the inv dict. Why? WHO KNOWS
	
	AUmanager.add_to_inventory("pulse1")
	#Remove and add ability from the list of player owned abils. Used to manage
	AUmanager.remove_from_inventory("pulse1")
	
	
	var removethis = get_node("../pulse1")
	removethis.remove()
	#Apparantly get node is not good to use. But Im too dumb to do it another way. Purges the previous ability from scene. 
	
	place = ui.place_button() #returns vec2 coords which are used to place ability buttons.
	$CanvasLayer/Button.position = place
	
func remove():
	#Called by the ability scene when added, purges previous ability from scene.
	ui.free_space(place)
	queue_free()
	
func _on_button_pressed():
	pass 
	#dooooo ability stuff
	#cooldown
	#ability content goes here e.g. pulse

