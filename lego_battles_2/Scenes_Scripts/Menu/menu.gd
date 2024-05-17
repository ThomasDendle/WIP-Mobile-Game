extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Start.grab_focus()
	#Makes the start button the starting selected option, can navigate menu with default controls

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes_Scripts/Menu/CharacterSelect.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes_Scripts/Menu/options.tscn")


func _on_quit_pressed():
	get_tree().quit()
