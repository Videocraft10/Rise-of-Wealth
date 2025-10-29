extends Control
var current_challenge: int = 0
var career_score: int = 0
@onready var challenge_container: Control = $ChallengeContainer
@onready var intro_panel: Panel = $IntroPanel
@onready var results_panel: Panel = $ResultsPanel

var challenge_scenes = [
"res://scenes/careers/challenges/strategic_decision_challenge.tscn",
"res://scenes/careers/challenges/team_leadership_challenge.tscn",
"res://scenes/careers/challenges/budget_management_challenge.tscn"
]

func _ready() -> void:
show_intro()

func show_intro() -> void:
intro_panel.show()
challenge_container.hide()
results_panel.hide()
var intro_text = intro_panel.get_node("VBoxContainer/IntroText")
if intro_text:
intro_text.text = """Welcome to the Business Manager Career!

Business managers lead teams, make strategic decisions, and drive organizational success.

You'll:
• Make strategic business decisions
• Lead and motivate teams
• Manage budgets and resources

Ready to lead?"""
var start_btn = intro_panel.get_node("VBoxContainer/StartButton")
if start_btn and not start_btn.pressed.is_connected(_on_intro_start_pressed):
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
show_results()

func _on_challenge_completed(score: int) -> void:
career_score += score
current_challenge += 1
await get_tree().create_timer(0.5).timeout
load_next_challenge()

func show_results() -> void:
challenge_container.hide()
results_panel.show()
var final_score = int(float(career_score) / 3.0)
GameManager.complete_career("business_manager", final_score)
var results_text = results_panel.get_node("VBoxContainer/ResultsText")
if results_text:
var msg = "Excellent leadership skills!" if final_score >= 70 else "Keep developing your management abilities!"
results_text.text = """Business Manager Career Complete!

Score: %d/100

%s

Skills gained:
• Strategic thinking
• Team leadership
• Budget management
• Decision-making""" % [final_score, msg]
var return_btn = results_panel.get_node("VBoxContainer/ReturnButton")
if return_btn and not return_btn.pressed.is_connected(_on_return_to_hub):
return_btn.pressed.connect(_on_return_to_hub)

func _on_return_to_hub() -> void:
get_tree().change_scene_to_file("res://scenes/career_quest/career_hub.tscn")
