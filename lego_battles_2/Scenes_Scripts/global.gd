extends Node

#I have 0 exp with this. God help me

#TODO this is a good place for storing high scores for each char, and keeping track of unlocked characters

var character_selected

var number_of_abilities = 3 #(0-2, 3 options when rand)
var number_of_upgrades = 3

func set_player_character(character):
	self.character_selected = character
