extends CanvasLayer

@export var next_scene_path: String = "res://scenes/First.tscn"

@onready var start_btn: Button = $StartButton
@onready var quit_btn: Button = $QuitButton

func _ready() -> void:
	start_btn.pressed.connect(Callable(self, "_on_start_pressed"))
	quit_btn.pressed.connect(Callable(self, "_on_quit_pressed"))

func _on_start_pressed() -> void:
	if FileAccess.file_exists(next_scene_path):
		var err = get_tree().change_scene(next_scene_path)
		if err != OK:
			push_error("Failed to change scene to '%s'" % next_scene_path)
	else:
		push_error("Scene file not found: '%s'" % next_scene_path)

func _on_quit_pressed() -> void:
	get_tree().quit()
