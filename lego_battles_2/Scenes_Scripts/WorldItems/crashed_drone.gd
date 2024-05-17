extends Node2D

@onready var UI = get_tree().get_nodes_in_group("UI")[0]
@onready var AUmanager = get_tree().get_nodes_in_group("AUmanager")[0]

func _on_area_2d_body_entered(body):
	
	if body.is_in_group("player"):
	#pick random number
		var abilorup = randi() % 4 #Picks between 0 and 3
		
		#TODO: change this to pick from the pool instead. 
		#if abilorup <= 2:
		var whatability = AUmanager.pickfromabilitypool()
		UI.ability_prompt(whatability)
		#print("give ability " + str(whatability))
		print("-----------------------")
		#else:
			#var whatupgrade = AUmanager.pickfromupgradepool()
			#UI.upgrade_prompt(whatupgrade)
			#print("give upgrade " + str(whatupgrade))
		
		#HUD will show popup to add to list or cash it out. 
		queue_free()
