extends Control

@export var next_scene_path: String = "res://scenes/Level1.tscn"

@onready var start_btn: Button = $StartButton
@onready var quit_btn: Button = $QuitButton

func _ready():
	start_btn.pressed.connect(_on_start_pressed)
	quit_btn.pressed.connect(_on_quit_pressed)

func _on_start_pressed():
	get_tree().change_scene_to_file(next_scene_path)

func _on_quit_pressed():
	get_tree().quit()
