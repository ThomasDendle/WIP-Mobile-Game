extends Control

@onready var ui = get_tree().get_nodes_in_group("UI")[0]
@onready var AUmanager = get_tree().get_nodes_in_group("AUmanager")[0]

var ability
var ability_cash

func recieve_ability_number(ability_rec):
	#called first. There has to be a better way to give variables across like this but I want it seperated rn
	ability = ability_rec
	
func _ready():
	get_tree().paused = true
	
func set_texture(ability):
	#Set the texture that shows up to be the appropiate one
	#if upgrade: $UpgradeNoTexture.texture = load("res://Assets/UpgradePrompts/" + upgrade + ".png")
	
	if ability: $AbilityNoTexture.texture = load("res://Assets/AbilityPrompts/" + ability + ".png")
	else: $AbilityNoTexture.texture = load("res://Assets/startingweaponbullet.png")


func _on_button_pressed():
	#ACCEPT give updrade/ability, replace if needed, close menu
	
	if AUmanager.check_ability_limit(ability): #e.g. if player at max slots
		
		ui.replacement_prompt()
		
	elif ability:
		#if abil is valid, go ahead and add it
		AUmanager.give_ability(ability)
	else: print("no ability found/left")
	get_tree().paused = false
	queue_free()

func _on_button_2_pressed():
	#CASH OUT 
	#TODO: rather than matching with all abilities, use dict key value
	match ability: 
		"pulse1":
			ability_cash = 10
		"teleport1":
			ability_cash = 20
		"misc1":
			ability_cash = 30
		_: 
			print("no ability cash value ")
	
	ui.update_money_HUD(ability_cash)
	
	get_tree().paused = false
	queue_free()
