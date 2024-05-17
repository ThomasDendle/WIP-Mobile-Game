extends Node2D


@onready var AUmanager = get_tree().get_nodes_in_group("AUmanager")[0]
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var ui = get_tree().get_nodes_in_group("UI")[0]
var this_ability
var place

func _ready():
	AUmanager.removefromabilitypool("pulse1") #curren abil
	AUmanager.addtoabilitypool("pulse2", 5) #lvl2
	AUmanager.add_to_inventory("pulse1")
	#AUmanager.remove_from_inventory()
	
	#var removethis = get_node("../pulse1")
	#removethis.remove()
	
	place = ui.place_button()
	$CanvasLayer/Button.position = place

func _process(delta):
	position = player.position
	
func remove():
	queue_free()

func _on_button_pressed():
	
	var range = $AOErange
	
	print("pulse activtated")
	
	var overlappingbodiesresult = range.get_overlapping_areas()
	print (overlappingbodiesresult)
	
	for obj in overlappingbodiesresult: #if given a list, it just goes through list, nice
		var n = obj.get_parent()
		if n.is_in_group("enemy"):
			print("yes")
			n.pulse_push()
		
		
	#if area.is_in_group("bullet"):
	#1 find all enemies in range, 
	#2 for each, calculate vector of opposite direction line from enemy to player
	#3 AND calculate distance from player, - distance from 100 to find scaling power effect
	#4. push away
	#5. cooldown
	
	
	
	

