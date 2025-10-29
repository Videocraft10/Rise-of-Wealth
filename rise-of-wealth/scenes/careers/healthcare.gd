extends Control
## Healthcare Professional Career World
## Challenges: Patient Diagnosis, Treatment Plan, Emergency Response

var current_challenge: int = 0
var challenges_completed: int = 0
var career_score: int = 0

@onready var challenge_container: Control = $ChallengeContainer
@onready var intro_panel: Panel = $IntroPanel
@onready var results_panel: Panel = $ResultsPanel

var challenge_scenes = [
	"res://scenes/careers/challenges/diagnosis_challenge.tscn",
	"res://scenes/careers/challenges/treatment_challenge.tscn",
	"res://scenes/careers/challenges/emergency_challenge.tscn"
]

func _ready() -> void:
	show_intro()

func show_intro() -> void:
	intro_panel.show()
	challenge_container.hide()
	results_panel.hide()
	
	var intro_text = intro_panel.get_node("VBoxContainer/IntroText")
	if intro_text:
		intro_text.text = """Welcome to the Healthcare Professional Career!

Healthcare professionals save lives, provide care, and make critical decisions that impact patients' wellbeing.

In this career world, you'll:
• Diagnose patients based on symptoms
• Create treatment plans for various conditions
• Respond to medical emergencies quickly and effectively

Each challenge tests the critical thinking and medical knowledge needed in healthcare. Are you ready to make a difference?"""
	
	var start_btn = intro_panel.get_node("VBoxContainer/StartButton")
	if start_btn:
		if not start_btn.pressed.is_connected(_on_intro_start_pressed):
			start_btn.pressed.connect(_on_intro_start_pressed)

func _on_intro_start_pressed() -> void:
	intro_panel.hide()
	load_next_challenge()

func load_next_challenge() -> void:
	if current_challenge < challenge_scenes.size():
		for child in challenge_container.get_children():
			child.queue_free()
		
		var challenge_scene = load(challenge_scenes[current_challenge])
		if challenge_scene:
			var challenge_instance = challenge_scene.instantiate()
			challenge_container.add_child(challenge_instance)
			challenge_container.show()
			
			if challenge_instance.has_signal("challenge_completed"):
				challenge_instance.challenge_completed.connect(_on_challenge_completed)
		else:
			push_error("Failed to load challenge: " + challenge_scenes[current_challenge])
	else:
		show_results()

func _on_challenge_completed(score: int) -> void:
	challenges_completed += 1
	career_score += score
	current_challenge += 1
	
	await get_tree().create_timer(0.5).timeout
	load_next_challenge()

func show_results() -> void:
	challenge_container.hide()
	results_panel.show()
	
	var final_score = int(float(career_score) / 3.0)
	GameManager.complete_career("healthcare", final_score)
	
	var results_text = results_panel.get_node("VBoxContainer/ResultsText")
	if results_text:
		var performance_msg = ""
		if final_score >= 80:
			performance_msg = "Outstanding! You have excellent healthcare instincts."
		elif final_score >= 60:
			performance_msg = "Well done! You show great potential in healthcare."
		else:
			performance_msg = "Keep learning! Healthcare requires continuous education."
		
		results_text.text = """Healthcare Professional Career Complete!

Your Final Score: %d/100

%s

You've experienced what it's like to be a healthcare professional:
✓ Diagnosing patient conditions
✓ Planning effective treatments
✓ Handling medical emergencies

Skills gained:
• Critical thinking
• Decision-making under pressure
• Patient care knowledge
• Medical reasoning""" % [final_score, performance_msg]
	
	var return_btn = results_panel.get_node("VBoxContainer/ReturnButton")
	if return_btn:
		if not return_btn.pressed.is_connected(_on_return_to_hub):
			return_btn.pressed.connect(_on_return_to_hub)

func _on_return_to_hub() -> void:
	get_tree().change_scene_to_file("res://scenes/career_quest/career_hub.tscn")
