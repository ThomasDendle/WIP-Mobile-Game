extends Area2D

var bullet_velocity = Vector2()
var bullet_type
#The only things bullets do is travel and hit things. 

func give_velocity(given_velocity):
	#Called when bullet is spawned. 
	bullet_velocity = given_velocity
	
func give_bullet_type(type):
	bullet_type = type
	#This could be hard coded, instead, bullet type is given when bullet is spawned,
	#so that the bullet can give that info to the enemy it hits. 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Moves the bullet, using translate since its an area2D
	translate(bullet_velocity * delta)

func _on_visible_on_screen_notifier_2d_screen_exited():
	#Deletes bullet when off screen.
	queue_free()
	
func bullet_hit():
	#print("i did it")
	#TODO: anim for bullets exploding on contact. 
	queue_free()
	
func return_bullet_type():
	return bullet_type
	
	
	 
