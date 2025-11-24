extends CanvasLayer

func _ready():
	visible = false  # Menu starts hidden

func _input(event):
	# Toggle pause when pressing ESC (ui_cancel)
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			resume_game()
		else:
			pause_game()

# Show pause menu and pause the game
func pause_game():
	visible = true
	get_tree().paused = true

# Hide pause menu and resume the game
func resume_game():
	visible = false
	get_tree().paused = false

# Button signals
func _on_ResumeButton_pressed():
	resume_game()

func _on_QuitButton_pressed():
	get_tree().quit()
