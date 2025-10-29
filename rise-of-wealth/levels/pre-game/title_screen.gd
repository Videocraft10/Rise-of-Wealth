extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called when Start Game button is pressed
func _on_start_button_pressed():
	# Load the test world scene
	get_tree().change_scene_to_file("res://test_world.tscn")

# Called when Quit button is pressed
func _on_quit_button_pressed():
	# Quit the game
	get_tree().quit()
