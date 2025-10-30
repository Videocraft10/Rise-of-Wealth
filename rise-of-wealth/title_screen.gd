extends CanvasLayer

@export var next_scene_path: String = "res://scenes/Game.tscn"  # your main game scene

# Node references
@onready var start_btn: Button = $StartButton
@onready var quit_btn: Button = $QuitButton

func _ready() -> void:
	# Connect button signals
	start_btn.pressed.connect(_on_start_pressed)
	quit_btn.pressed.connect(_on_quit_pressed)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(next_scene_path)

func _on_quit_pressed() -> void:
	get_tree().quit()
