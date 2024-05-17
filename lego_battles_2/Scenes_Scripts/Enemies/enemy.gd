extends CharacterBody2D

@onready var player = get_tree().get_nodes_in_group("player")[0] #This gets the first (0th) node within the "player" group
@onready var UI = get_tree().get_nodes_in_group("UI")[0]
@onready var attack_pause_timer = $AttackPause

#Enemy variables
var player_position
var target_position
var enemySpeed
var enemyHealth 
var enemyValue
var attack_type #I am aware I am mixing camel case with this_style
var bullet_type
signal give_money(enemyValue)
var attack_pause : bool = false
var colliding_with_player : bool = false
#Enemies will all share this script

func set_enemy_type(enemyType):
	#Working(?)(yes actually!!
	match enemyType:
		1: #Workers
			enemySpeed = 100
			enemyHealth = 2000
			enemyValue = 10
			attack_type = 1 #cut
		2: #Grabbers
			enemySpeed = 350
			enemyHealth = 100
			enemyValue = 25
			attack_type = 2 #grabbed
		3: #Spitters
			enemySpeed = 50
			enemyHealth = 30
			enemyValue = 50
			attack_type = 3 #TODO: this enemy spits acid.
		_: #Default
			print("no enemy type recieved")

func pulse_push():
	#player_position = player.position
	#target_position = (position - player.position).normalized()
	#velocity = target_position * 1000
	#move_and_slide()
	velocity = (Vector2(0,-30000))
	move_and_slide()

func _physics_process(delta):   
	#print(str(colliding_with_player))
	
	player_position = player.position
	target_position = (player_position - position).normalized() #big brain maths things going on here
	velocity = target_position * enemySpeed
	
	#TODO: using an if, enemy 3 only follow at range, and do its shoot
	if !attack_pause:  #enemies 1 & 2 will not move when they attack
		move_and_slide() 	
		look_at(player_position)
	#CharacterBody3D.move_and_slide() is a powerful method of the CharacterBody3D class that allows
	#you to move a character smoothly. If it hits a wall midway through a motion, the engine will 
	#try to smooth it out for you. It uses the velocity value native to the CharacterBody3D
	
	#Iterate through all collisions that occured this frame
	for index in range (get_slide_collision_count()):
		var collision = get_slide_collision(index) #We get one of the collisions with the player
		if collision.get_collider().is_in_group("player"):
			#var player = collision.get_collider()
			colliding_with_player = true
			melee_attack(attack_type)

func melee_attack(attack_type):
	
	if attack_pause: return #if in attack cooldown, dont do this attack
	
	#2 kinds of attacks, close range and long range, close range are activated by collision,
	#this will suck in future, but works for now
	match attack_type:
		1:
			player.attack_cut()
			#freeze enemy for a second
		2:
			player.attack_grapple()
			#freeze player until tap on enemy
		_:
			print("Invalid attack type")
	
	attack_pause = true
	attack_pause_timer.start() 
	#like the gun, enemy attacks must be limited by a timer.
	#Each enemy can have their timer, or "rate of fire" changed individually.
	
	
func ranged_attack(attack_type):
	pass #TODO: Here is where enemy 3 will shoot a bullet at the player	
	
func _on_attack_pause_timeout():
	attack_pause = false

func _on_bullet_hitbox_area_entered(area):
	
	if area.is_in_group("bullet"):
		bullet_type = area.return_bullet_type()
		area.bullet_hit()
		take_damage(bullet_type)
		#if hit by bullet, call delete on bullet and take damage, grabbing bullet type

func take_damage(bullet_type):
	#print(str(bullet_type))
	
	#ifs for now, replacce with match
	if bullet_type == 0:
		enemyHealth -= 5
		#other effects here, like slowdown, poison, etc
	else: print("no bullet type found")
	
	if enemyHealth <= 0:
		die()
	#find out what kind of bullet, apply correct dmg + effects
	
	#TODO all this
	
func die():
	UI.update_money_HUD(enemyValue)
	
	if attack_type == 2 && colliding_with_player == true:
		player.free_grapple() #will only do anything if a grabber enemy dies, 
		
		
	
	queue_free()
	
	#TODO other death effects


func test():
	print("AAAAAAAA")
