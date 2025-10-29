extends Control
signal challenge_completed(score: int)
var challenge_score: int = 0
var selected_answer: int = -1
@onready var problem_text: RichTextLabel = $VBoxContainer/ProblemPanel/ProblemText
@onready var options_container: VBoxContainer = $VBoxContainer/OptionsContainer
@onready var feedback_label: Label = $VBoxContainer/FeedbackLabel
@onready var submit_button: Button = $VBoxContainer/SubmitButton

func _ready() -> void:
problem_text.text = """[b]Lesson Planning Challenge[/b]

You need to teach fractions to 4th graders.
Which approach is most effective?"""
var options = [
"Lecture only with textbook examples",
"Use pizza slices and visual aids with hands-on activities",
"Assign homework without explanation",
"Show a video and give a test"
]
for i in range(options.size()):
var radio = CheckBox.new()
radio.text = options[i]
radio.theme_override_font_sizes/font_size = 18
radio.toggle_mode = true
radio.pressed.connect(_on_option_selected.bind(i))
options_container.add_child(radio)
feedback_label.text = "Select the best teaching method"
submit_button.pressed.connect(_on_submit_pressed)

func _on_option_selected(idx: int) -> void:
selected_answer = idx
var children = options_container.get_children()
for i in range(children.size()):
if i != idx:
children[i].button_pressed = false

func _on_submit_pressed() -> void:
if selected_answer == -1:
return
challenge_score = 100 if selected_answer == 1 else 40
feedback_label.text = "✅ Correct! Hands-on learning is most effective." if selected_answer == 1 else "❌ Hands-on activities work best for this age group."
submit_button.disabled = true
await get_tree().create_timer(2.0).timeout
challenge_completed.emit(challenge_score)
