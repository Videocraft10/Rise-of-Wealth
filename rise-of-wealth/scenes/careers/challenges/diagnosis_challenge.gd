extends Control
## Diagnosis Challenge - Identify patient condition
signal challenge_completed(score: int)

var challenge_score: int = 0
var selected_answer: int = -1

@onready var case_text: RichTextLabel = $VBoxContainer/CasePanel/CaseText
@onready var options_container: VBoxContainer = $VBoxContainer/OptionsContainer
@onready var feedback_label: Label = $VBoxContainer/FeedbackLabel
@onready var submit_button: Button = $VBoxContainer/SubmitButton

var correct_answer: int = 1
var options = [
	"Common cold - prescribe rest and fluids",
	"Type 2 Diabetes - requires blood test and treatment plan",
	"Food poisoning - will resolve on its own",
	"Anxiety disorder - refer to psychologist only"
]

func _ready() -> void:
	setup_challenge()
	submit_button.pressed.connect(_on_submit_pressed)

func setup_challenge() -> void:
	var case_desc = """[b]Patient Case Study[/b]

[b]Patient Information:[/b]
• Age: 45 years old
• Chief Complaint: Increased thirst, frequent urination, fatigue

[b]Symptoms:[/b]
• Excessive thirst (polydipsia) for 3 weeks
• Urinating frequently, especially at night
• Unexplained weight loss (10 lbs in 2 months)
• Constant tiredness and lack of energy
• Blurred vision occasionally

[b]Vital Signs:[/b]
• Blood Pressure: 140/90 mmHg (slightly elevated)
• Heart Rate: 78 bpm (normal)
• Temperature: 98.6°F (normal)

[b]Your Diagnosis:[/b]
Based on these symptoms, what is the most likely condition?"""
	
	case_text.text = case_desc
	
	for i in range(options.size()):
		var radio = CheckBox.new()
		radio.text = options[i]
		radio.theme_override_font_sizes/font_size = 18
		radio.toggle_mode = true
		radio.pressed.connect(_on_option_selected.bind(i))
		options_container.add_child(radio)
	
	feedback_label.text = "Select your diagnosis"

func _on_option_selected(option_index: int) -> void:
	selected_answer = option_index
	var children = options_container.get_children()
	for i in range(children.size()):
		if i != option_index:
			children[i].button_pressed = false

func _on_submit_pressed() -> void:
	if selected_answer == -1:
		feedback_label.text = "Please select a diagnosis!"
		return
	
	if selected_answer == correct_answer:
		challenge_score = 100
		feedback_label.text = """✅ Correct Diagnosis!

Type 2 Diabetes is the correct answer.

[b]Key Indicators:[/b]
• Polydipsia (excessive thirst)
• Polyuria (frequent urination)
• Unexplained weight loss
• Fatigue and blurred vision

These are classic symptoms of diabetes. Blood glucose testing would confirm the diagnosis.

Score: 100/100"""
	else:
		challenge_score = 30
		feedback_label.text = """❌ Incorrect

The correct diagnosis is Type 2 Diabetes.

The combination of excessive thirst, frequent urination, weight loss, and fatigue are hallmark symptoms of diabetes. This requires immediate attention and blood testing.

Score: 30/100"""
	
	submit_button.disabled = true
	for child in options_container.get_children():
		child.disabled = true
	
	await get_tree().create_timer(3.0).timeout
	challenge_completed.emit(challenge_score)
