extends CanvasLayer

var upgrade_prompt_scene = preload("res://Scenes_Scripts/UI/upgrade_prompt.tscn")
var ability_prompt_scene = preload("res://Scenes_Scripts/UI/abilities_prompt.tscn")

@onready var selected_building = 0 #0 = nothing
@onready var mouse_state = 0 #Either in building "mode" or not.
@onready var event_pos

@onready var money_HUD = $HUD/Money #This throws an error if I use UI/Money, I guess dont include parents in scripts youre already in
@onready var health_HUD = $HUD/Health
@onready var AbilitySpot1 = $HUD/AbilitySpot1
@onready var AbilitySpot2 = $HUD/AbilitySpot2
@onready var AbilitySpot3 = $HUD/AbilitySpot3
@onready var AbilitySpot4 = $HUD/AbilitySpot4

var AbilitySpot1full: bool
var AbilitySpot2full: bool
var AbilitySpot3full: bool
var AbilitySpot4full: bool
var place = Vector2(0,0)

@onready var main = get_tree().get_nodes_in_group("main")[0]

@export var starting_money = 100
@export var starting_health = 100

var new_money = 0
signal spawn_building(selected_building)

func _ready():
	update_money_HUD(starting_money) #Giving the starting values for money and health to display. 
	update_health_HUD(starting_health)
	new_money = starting_money
	
func update_money_HUD(money_value):
	
	new_money += money_value
	money_HUD.text = "money: " + str(new_money)
	
	#This got weirdly difficult. Remember its += for "thing equals thing + thing2
	
func update_health_HUD(new_health):
	
	health_HUD.text = "health: " + str(new_health)
	#Player class manages its health, this just updates UI

func _process(delta):
	
	#print("mousestate: " + str(mouse_state))
	#print("selectedbuilding: " + str(selected_building))
	
	if Input.is_action_pressed("left_click") && mouse_state == 1: #AND mouse not over a HUD element
		emit_signal("spawn_building", selected_building) 
		
		#Here is where the signal to place building goes off a million times, slowing it down should be here
#
#func _input(event):
		#if event is InputEventMouse && is_action_pressed("left_click") && mouse_state == 1:
			#event = make_input_local(event)
			#event_pos = event.position
			#emit_signal("spawn_building", selected_building, event_pos )

func place_button():
	#im getting so lost now
	
	if !AbilitySpot1full:
		place = AbilitySpot1.position
		AbilitySpot1full = true
		print("placing at slot 1")
	elif !AbilitySpot2full:
		place = AbilitySpot2.position
		AbilitySpot2full = true
		print("placing at slot 2")
	elif !AbilitySpot3full:
		place = AbilitySpot3.position
		AbilitySpot3full = true
		print("placing at slot 3")
	elif !AbilitySpot4full:
		place = AbilitySpot4.position
		AbilitySpot2full = true	
		print("placing at slot 4")
	return place
	
func clear_slot(place):
	pass

func upgrade_prompt(upgrade):
	#print("up" + str(upgrade_no))
	#This is just the UI prompt. 
	var upgrade_prompt_instance = upgrade_prompt_scene.instantiate()
	upgrade_prompt_instance.set_texture(upgrade)
	upgrade_prompt_instance.recieve_upgrade_number(upgrade)
	add_child(upgrade_prompt_instance)	
	#actually works, cool
	#All the UI does is make the prompt show up. 

	
func ability_prompt(ability):
	#print("abil" + str(ability_no))
	var ability_prompt_instance = ability_prompt_scene.instantiate()
	ability_prompt_instance.set_texture(ability)
	ability_prompt_instance.recieve_ability_number(ability)
	add_child(ability_prompt_instance)
	#This is just the UI prompt. 
	

func replacement_prompt():
	print("FULL")
	#TODO
#	$AbilityNoTexture.visible = false
	#AbilityReplaceScreen.visible = true
	#show list of the abiltiies they have so far, have them choose one
	#AUmanager.removeability(chosentoremoveability)
	#AUmanager.give_ability(ability)
	#Something like this ^


func _on_cancel_building_pressed():
	mouse_state = 0
	selected_building = 0


func _on_other_pressed():
	mouse_state = 1
	selected_building = 2


func _on_arc_tower_pressed():
	mouse_state = 1
	selected_building = 1
