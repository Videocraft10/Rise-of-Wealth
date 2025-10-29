extends Control
signal challenge_completed(score: int)

var challenge_score: int = 0
var selected_answer: int = -1
var time_taken: float = 0.0
var timer_running: bool = true

@onready var scenario_text: RichTextLabel = $VBoxContainer/ScenarioPanel/ScenarioText
@onready var options_container: VBoxContainer = $VBoxContainer/OptionsContainer
@onready var feedback_label: Label = $VBoxContainer/FeedbackLabel
@onready var timer_label: Label = $VBoxContainer/TopBar/TimerLabel
@onready var submit_button: Button = $VBoxContainer/SubmitButton

var correct_answer: int = 2

func _ready() -> void:
setup_challenge()
submit_button.pressed.connect(_on_submit_pressed)

func setup_challenge() -> void:
scenario_text.text = """[b]Emergency Response Challenge[/b]

[b]EMERGENCY SITUATION:[/b]
Patient arrives unconscious, not breathing normally.
Bystander reports possible heart attack.

[b]What is your FIRST action?[/b]"""

var options = [
"Call for more help and wait",
"Check pulse and start detailed examination",
"Start CPR immediately and call code blue",
"Give patient water"
]

for i in range(options.size()):
var radio = CheckBox.new()
radio.text = options[i]
radio.theme_override_font_sizes/font_size = 18
radio.toggle_mode = true
radio.pressed.connect(_on_option_selected.bind(i))
options_container.add_child(radio)

feedback_label.text = "Quick! Make a decision - time matters!"

func _process(delta: float) -> void:
if timer_running:
time_taken += delta
timer_label.text = "Time: %.1fs" % time_taken

func _on_option_selected(option_index: int) -> void:
selected_answer = option_index
var children = options_container.get_children()
for i in range(children.size()):
if i != option_index:
children[i].button_pressed = false

func _on_submit_pressed() -> void:
if selected_answer == -1:
return

timer_running = false

if selected_answer == correct_answer:
var time_bonus = max(0, 30 - int(time_taken / 2))
challenge_score = min(100, 100 + time_bonus)
feedback_label.text = "✅ Correct! CPR should start immediately in cardiac arrest. Time: %.1fs. Score: %d/100" % [time_taken, challenge_score]
else:
challenge_score = 40
feedback_label.text = "❌ In cardiac emergencies, immediate CPR is critical. Every second counts! Score: %d/100" % challenge_score

submit_button.disabled = true
await get_tree().create_timer(3.0).timeout
challenge_completed.emit(challenge_score)
