extends Control

@onready var AUmanager = get_tree().get_nodes_in_group("AUmanager")[0]
var upgrade

func recieve_upgrade_number(upgrade_rec):
	#called first. There has to be a better way to give variables across like this but I want it seperated rn
	upgrade = upgrade_rec #Not a number btw, a dict
	
func _ready():
	get_tree().paused = true
	#at least its this easy to pause the game. dont forget to set process mode for the prompt to ALWAYS

func set_texture(upgrade):
	#Set the texture that shows up to be the appropiate one
	
	if upgrade: $UpgradeNoTexture.texture = load("res://Assets/UpgradePrompts/" + upgrade + ".png")
	else: $UpgradeNoTexture.texture = load("res://Assets/startingweaponbullet.png")
	#This isnt great, using words like this. But I dont know how else to improve it
	
	#I have absolutely no idea why, but this wont work using a variable that used $ rather than using
	#$ directly. Stupid. Silly. 

func _on_button_pressed():
	#give updrade, unpause game and close menu
	if upgrade:
		AUmanager.give_upgrade(upgrade)
	else: print("no upgrade found/left")
	get_tree().paused = false
	queue_free()
