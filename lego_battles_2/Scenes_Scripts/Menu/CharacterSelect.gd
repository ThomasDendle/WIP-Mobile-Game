extends Control

var character = 0

func _on_start_pressed():
	Global.set_player_character(character)
	get_tree().change_scene_to_file("res://Scenes_Scripts/main.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes_Scripts/Menu/menu.tscn")


func _on_button_pressed():
	character = 0
	print(str(character) + " selected")


func _on_button_2_pressed():
	character = 1
	print(str(character) + " selected")

func _on_button_3_pressed():
	character = 2
	print(str(character) + " selected")


func _on_button_4_pressed():
	character = 3
	print(str(character) + " selected")
