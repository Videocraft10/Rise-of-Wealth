extends Control
## Software Developer Career World
## Challenges: Code Debugging, Algorithm Puzzle, Feature Implementation

var current_challenge: int = 0
var challenges_completed: int = 0
var career_score: int = 0

@onready var challenge_container: Control = $ChallengeContainer
@onready var intro_panel: Panel = $IntroPanel
@onready var results_panel: Panel = $ResultsPanel

# Challenge references
var challenge_scenes = [
	"res://scenes/careers/challenges/debug_challenge.tscn",
	"res://scenes/careers/challenges/algorithm_challenge.tscn",
	"res://scenes/careers/challenges/feature_challenge.tscn"
]

func _ready() -> void:
	# Show introduction
	show_intro()

func show_intro() -> void:
	"""Display career introduction"""
	intro_panel.show()
	challenge_container.hide()
	results_panel.hide()
	
	var intro_text = intro_panel.get_node("VBoxContainer/IntroText")
	if intro_text:
		intro_text.text = """Welcome to the Software Developer Career!

As a software developer, you'll write code, solve problems, and create applications that make people's lives easier.

In this career world, you'll:
• Debug broken code to find and fix errors
• Solve algorithm puzzles efficiently
• Implement new features based on requirements

Each challenge tests different skills needed in software development. Are you ready to code your way to success?"""
	
	var start_btn = intro_panel.get_node("VBoxContainer/StartButton")
	if start_btn:
		if not start_btn.pressed.is_connected(_on_intro_start_pressed):
			start_btn.pressed.connect(_on_intro_start_pressed)

func _on_intro_start_pressed() -> void:
	intro_panel.hide()
	load_next_challenge()

func load_next_challenge() -> void:
	"""Load the next challenge in the sequence"""
	if current_challenge < challenge_scenes.size():
		# Clear previous challenge
		for child in challenge_container.get_children():
			child.queue_free()
		
		# Load new challenge scene
		var challenge_scene = load(challenge_scenes[current_challenge])
		if challenge_scene:
			var challenge_instance = challenge_scene.instantiate()
			challenge_container.add_child(challenge_instance)
			challenge_container.show()
			
			# Connect to challenge completion signal
			if challenge_instance.has_signal("challenge_completed"):
				challenge_instance.challenge_completed.connect(_on_challenge_completed)
		else:
			push_error("Failed to load challenge: " + challenge_scenes[current_challenge])
	else:
		# All challenges completed
		show_results()

func _on_challenge_completed(score: int) -> void:
	"""Handle challenge completion"""
	challenges_completed += 1
	career_score += score
	current_challenge += 1
	
	# Small delay before loading next challenge
	await get_tree().create_timer(0.5).timeout
	load_next_challenge()

func show_results() -> void:
	"""Show final results and career completion"""
	challenge_container.hide()
	results_panel.show()
	
	var final_score = int(float(career_score) / 3.0)  # Average of 3 challenges
	
	# Save career completion
	GameManager.complete_career("software_developer", final_score)
	
	var results_text = results_panel.get_node("VBoxContainer/ResultsText")
	if results_text:
		var performance_msg = ""
		if final_score >= 80:
			performance_msg = "Excellent work! You have strong software development skills."
		elif final_score >= 60:
			performance_msg = "Good job! You show promise as a developer."
		else:
			performance_msg = "Keep practicing! Every developer starts somewhere."
		
		results_text.text = """Software Developer Career Complete!

Your Final Score: %d/100

%s

You've experienced what it's like to be a software developer:
✓ Debugging code issues
✓ Solving algorithmic problems
✓ Implementing new features

Skills gained:
• Problem-solving
• Logical thinking
• Attention to detail
• Code comprehension""" % [final_score, performance_msg]
	
	var return_btn = results_panel.get_node("VBoxContainer/ReturnButton")
	if return_btn:
		if not return_btn.pressed.is_connected(_on_return_to_hub):
			return_btn.pressed.connect(_on_return_to_hub)

func _on_return_to_hub() -> void:
	"""Return to career hub"""
	get_tree().change_scene_to_file("res://scenes/career_quest/career_hub.tscn")
