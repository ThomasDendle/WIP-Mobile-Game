extends Node2D

@onready var AUmanager = get_tree().get_nodes_in_group("AUmanager")[0]
@onready var ui = get_tree().get_nodes_in_group("UI")[0]

#Preloading all our ab and ups
var armour1_scene = preload("res://Scenes_Scripts/Upgrades/armour1.tscn")
var armour2_scene = preload("res://Scenes_Scripts/Upgrades/armour2.tscn")
var armour3_scene = preload("res://Scenes_Scripts/Upgrades/armour3.tscn")
var speed1_scene = preload("res://Scenes_Scripts/Upgrades/speed1.tscn")
var speed2_scene = preload("res://Scenes_Scripts/Upgrades/speed2.tscn")
var speed3_scene = preload("res://Scenes_Scripts/Upgrades/speed3.tscn")
var cooldown1_scene = preload("res://Scenes_Scripts/Upgrades/cooldown1.tscn")
var cooldown2_scene = preload("res://Scenes_Scripts/Upgrades/cooldown2.tscn")
var cooldown3_scene = preload("res://Scenes_Scripts/Upgrades/cooldown3.tscn")

var pulse1_scene = preload("res://Scenes_Scripts/Abilities/pulse1.tscn")
var pulse2_scene = preload("res://Scenes_Scripts/Abilities/pulse2.tscn")
var pulse3_scene = preload("res://Scenes_Scripts/Abilities/pulse3.tscn")
var stun1_scene = preload("res://Scenes_Scripts/Abilities/stun1.tscn")
var stun2_scene = preload("res://Scenes_Scripts/Abilities/stun2.tscn")
var stun3_scene = preload("res://Scenes_Scripts/Abilities/stun3.tscn")
var tele1_scene = preload("res://Scenes_Scripts/Abilities/tele1.tscn")
var tele2_scene = preload("res://Scenes_Scripts/Abilities/tele2.tscn")
var tele3_scene = preload("res://Scenes_Scripts/Abilities/tele3.tscn")

var chosen_upgrade
var chosen_ability
var ability_inv_no
var ability_limit

var abilitypoollevel1 = {"pulse1":1, "stun1":4, "tele1":7} #only used for a thing later
var ability_is_level_1

var abilitypool = {"pulse1":1 } #, "stun1":4, "tele1":7} ##OVERWRITTEN FOR TESTING
var abilitypoolindex = abilitypool.size()

var upgradepool = {"armour1":1,"speed1":4,"cooldown1":7} #only level 1 of each to begin
var upgradepoolindex = upgradepool.size()

var players_abilities = {}
var players_abilities_index = players_abilities.size()

func _ready():
	print(abilitypool)
	print(upgradepool)
	print(upgradepoolindex)
	print(abilitypoolindex)
	
	ability_inv_no = 0
	
#Managers job is the adding and holding of abilities/upgrades, and managing the pool of available ones.

#Ability inventory management

func add_to_inventory(ability):
	#Each ability will call here to add itself to the list of players owned abilities
	#If the ability is a level 1, e.g. will need a new slot, give it the next number in the inv. 
	#Otherwise let upgraded ability take over the slot no
	if abilitypoollevel1.has(ability):
		ability_inv_no += 1
	players_abilities[ability] = ability_inv_no
	print("ability_inv_no " + str(ability_inv_no))
	
func remove_from_inventory(ability):
	#Each ability will call here to remove itself to the list of players owned abilities
	players_abilities.erase(ability)
	
func set_ability_limit(limit):
	#From player setup, establishes max ability slots
	ability_limit = limit
	#print(limit)
	
func check_ability_limit(ability):
	#If the ability is a level 2 or above, it doesnt matter if slots are full since it will replace its previous level
	#So, I need to check for both is it a level 1 and are slots full 
	
	if abilitypoollevel1.has(ability): #If the new dict of just level1's has this ability
		ability_is_level_1 = true 
		#print(ability_is_level_1)
	else: ability_is_level_1 = false
	
	players_abilities_index = players_abilities.size()
	#print(players_abilities_index)
	#print(ability_limit)

	#If the limit is reached, and the ability is level 1, enable replacing
	if players_abilities_index == ability_limit && ability_is_level_1:
		#print("true")
		return true
	else:
		return false
	
#Adding abilities and upgrades from the player. Removal of abilities is done by ability scenes

func give_upgrade(upgrade):
	#add as child to scene. Is it good to use match here?
	var upgrade_to_add
	
	#TODO: there HAS to be a less ugly way of doing this
	match upgrade: 
		"armour1":
			upgrade_to_add = armour1_scene.instantiate()
		"armour2":
			upgrade_to_add = armour2_scene.instantiate()
		"armour3":
			upgrade_to_add = armour3_scene.instantiate()
		"speed1":
			upgrade_to_add = speed1_scene.instantiate()
		"speed2":
			upgrade_to_add = speed2_scene.instantiate()
		"speed3":
			upgrade_to_add = speed3_scene.instantiate()
		"cooldown1":
			upgrade_to_add = cooldown1_scene.instantiate()
		"cooldown2":
			upgrade_to_add = cooldown2_scene.instantiate()
		"cooldown3":
			upgrade_to_add = cooldown3_scene.instantiate()
		_:
			print("no upgrade found")
			
	print("given up " + str(upgrade))
	add_child(upgrade_to_add)
	#print("given up " + str(upgrade))
	
func give_ability(ability):
	var ability_to_add
	
	#TODO: there HAS to be a less ugly way of doing this. 
	#Maybe a dict key can hold a value that is the string name for the scene
	
	match ability: 
		"pulse1":
			ability_to_add = pulse1_scene.instantiate()
		"pulse2":
			ability_to_add = pulse2_scene.instantiate()
		"pulse3":
			ability_to_add = pulse3_scene.instantiate()
		"stun1":
			ability_to_add = stun1_scene.instantiate()
		"stun2":
			ability_to_add = stun2_scene.instantiate()
		"stun3":
			ability_to_add = stun3_scene.instantiate()
		"tele1":
			ability_to_add = tele1_scene.instantiate()
		"tele2":
			ability_to_add = tele2_scene.instantiate()
		"tele3":
			ability_to_add = tele3_scene.instantiate()
		_:
			print("no ability found")
			
	
	add_child(ability_to_add) #add to scene
	#ui.add_button(ability) #Add or update the button
	#print("given ab " + str(ability))
	print(players_abilities) #list of players current owned abs
	
#Pool management
	
func pickfromabilitypool():
	#randomize() - not neccessary in godot 4 apparantly
	abilitypoolindex = abilitypool.size()
	
	if abilitypoolindex > 0:
		chosen_ability = abilitypool.keys()[randi() % abilitypool.size()]
		return chosen_ability
	else:
		print("nothing left in ability pool")
		print(abilitypoolindex)

func pickfromupgradepool():
	
	upgradepoolindex = upgradepool.size()
	
	if upgradepoolindex > 0:
		chosen_upgrade = upgradepool.keys()[randi() % upgradepool.size()]
		return chosen_upgrade
	else:
		print("nothing left in upgrade pool")
		print(upgradepoolindex)
	
func addtoabilitypool(ability, ability_no):
	abilitypool[ability] = ability_no
	#print("added " + ability + " to pool")
	#When an abilility or upgrade added, add its next version to the pool
	
func removefromabilitypool(ability):
	#when an ability or up is added, remove itself from the pool of available abilties
	abilitypool.erase(ability)
	#print("removed " + ability + " from pool")
	
func addtoupgradepool(upgrade, upgrade_no): 
	#Each upgrade will have its own script, so dont be afraid to be specific#upgradepoolindex += 1
	upgradepool[upgrade] = upgrade_no
	#print("added " + upgrade + " to pool")
	#Nice! Works!
		
func removefromupgradepool(upgrade):
	upgradepool.erase(upgrade)
	#print("removed " + upgrade + " from pool")
