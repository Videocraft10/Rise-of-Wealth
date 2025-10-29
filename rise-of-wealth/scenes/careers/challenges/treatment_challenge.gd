extends Control
signal challenge_completed(score: int)

var challenge_score: int = 0
var selected_treatments: Array = []

@onready var patient_info: RichTextLabel = $VBoxContainer/InfoPanel/PatientInfo
@onready var treatments_container: VBoxContainer = $VBoxContainer/TreatmentsContainer
@onready var feedback_label: Label = $VBoxContainer/FeedbackLabel
@onready var submit_button: Button = $VBoxContainer/SubmitButton

var treatments = [
{"text": "Prescribe Metformin (diabetes medication)", "correct": true},
{"text": "Recommend dietary changes (low sugar, balanced meals)", "correct": true},
{"text": "Advise regular exercise program", "correct": true},
{"text": "Schedule follow-up appointments for monitoring", "correct": true},
{"text": "Prescribe antibiotics", "correct": false},
{"text": "Recommend bed rest only", "correct": false},
]

func _ready() -> void:
setup_challenge()
submit_button.pressed.connect(_on_submit_pressed)

func setup_challenge() -> void:
patient_info.text = """[b]Treatment Planning Challenge[/b]

[b]Patient:[/b] 45-year-old with newly diagnosed Type 2 Diabetes
Blood glucose: 180 mg/dL (elevated)

[b]Your Task:[/b]
Select appropriate treatments for this patient.
Choose all that apply."""

for i in range(treatments.size()):
var checkbox = CheckBox.new()
checkbox.text = treatments[i].text
checkbox.theme_override_font_sizes/font_size = 18
checkbox.toggled.connect(_on_treatment_toggled.bind(i))
treatments_container.add_child(checkbox)

feedback_label.text = "Select appropriate treatments"

func _on_treatment_toggled(toggled_on: bool, index: int) -> void:
if toggled_on:
if index not in selected_treatments:
selected_treatments.append(index)
else:
selected_treatments.erase(index)

func _on_submit_pressed() -> void:
var correct = 0
var incorrect = 0

for idx in selected_treatments:
if treatments[idx].correct:
correct += 1
else:
incorrect += 1

var total_correct = 4
challenge_score = int((float(correct) / total_correct) * 100)
challenge_score -= incorrect * 15
challenge_score = max(0, challenge_score)

if correct == total_correct and incorrect == 0:
feedback_label.text = "✅ Perfect treatment plan! Score: %d/100" % challenge_score
else:
feedback_label.text = "Treatment plan needs improvement. Correct: %d/%d. Score: %d/100" % [correct, total_correct, challenge_score]

submit_button.disabled = true
await get_tree().create_timer(3.0).timeout
challenge_completed.emit(challenge_score)
