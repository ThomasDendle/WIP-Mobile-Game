extends Node2D

@onready var AUmanager = get_tree().get_nodes_in_group("AUmanager")[0]
@onready var player = get_tree().get_nodes_in_group("player")[0]

#armour1



func _ready():
	AUmanager.removefromupgradepool("cooldown2") #curren upgrade
	AUmanager.addtoupgradepool("cooldown3",9) #lvl2

	#upgrade content goes here e.g. add 5 health

