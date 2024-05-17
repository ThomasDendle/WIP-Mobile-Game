extends CharacterBody2D

var playerSpeed = 300
var playerHealth = 100
var grappled : bool = false
var grapple_meter = 0

signal playerHit(newHealth)
signal kill_enemy()

@onready var AUmanager = get_tree().get_nodes_in_group("AUmanager")[0]
@onready var UI = get_tree().get_nodes_in_group("UI")[0]
@onready var grapple_button = $CanvasLayer/GrappleButton

func _ready():
	grapple_button.disabled = true
	grapple_button.visible = false
	
	
func finish_setup(x):
	#change health, speed, add gimmicks. A match is used here to point to each unique setup func. is this too much for the player script?
	match x:	 
		0:
			setup_playerchar_0(x)
		1:
			setup_playerchar_1(x)
		_:
			print("no character profile found")
	
func setup_playerchar_0(x):
	#Set skin
	#Set health, speed
	#Give bonuses/gimmicks
	AUmanager.set_ability_limit(4)
	print("character " + str(x) + " setup")
	
func setup_playerchar_1(x):
	print("character " + str(x) + " setup")
	
func _physics_process(delta): 
	
	#Movement
	velocity = Vector2(0,0) #velocity is a built in variable for characterbody
	
	if Input.is_action_pressed("move_right"):
		velocity.x = playerSpeed 
	if Input.is_action_pressed("move_left"):
		velocity.x = -playerSpeed 
	if Input.is_action_pressed("move_up"):
		velocity.y = -playerSpeed 
	if Input.is_action_pressed("move_down"):
		velocity.y = playerSpeed 
		
	if !grappled:
		move_and_slide()
		#a built in function of characterbody, handles movement. player wont move if grappled.
	
	#Restricting Player Movement to within window
	#var screen_size = get_viewport_rect().size	
	#global_position = global_position.clamp(Vector2(0,0), screen_size)
	
	#print(velocity) 
	#print(global_position)	#position of node script is attached to.
	#print(screen_size) 
	#print(str(grapple_meter))

func attack_cut():
	print("player cut")
	playerHealth -= 10
	UI.update_health_HUD(playerHealth)
	
func attack_grapple():
	grapple_meter = 0
	grappled = true #Player wont be able to move when grappled.
	grapple_button.disabled = false
	grapple_button.visible = true
	print("grappled")
	
	
func free_grapple():
	grappled = false
	grapple_button.disabled = true
	grapple_button.visible = false
	#find a way to kill enemy that grappled me
	
	
func _on_grapple_button_pressed():
	grapple_meter += 1
	if grapple_meter >= 5:
		free_grapple()
		
	#When a grappler enemy gets within range, enemy "Grabs" player, doing no damage
	#Tap them to remove
