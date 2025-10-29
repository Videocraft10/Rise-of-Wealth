extends Control
## Feature Implementation Challenge - Plan and implement a feature
## Part of Software Developer career

signal challenge_completed(score: int)

var challenge_score: int = 0
var selected_steps: Array = []

@onready var requirement_text: RichTextLabel = $VBoxContainer/RequirementPanel/RequirementText
@onready var steps_container: VBoxContainer = $VBoxContainer/StepsContainer
@onready var feedback_label: Label = $VBoxContainer/FeedbackLabel
@onready var submit_button: Button = $VBoxContainer/SubmitButton

# Correct implementation steps in order
var implementation_steps = [
	{"id": 0, "text": "1. Understand requirements and edge cases", "order": 1, "correct": true},
	{"id": 1, "text": "2. Design the database schema", "order": 2, "correct": true},
	{"id": 2, "text": "3. Write unit tests (TDD approach)", "order": 3, "correct": true},
	{"id": 3, "text": "4. Implement the backend API", "order": 4, "correct": true},
	{"id": 4, "text": "5. Create the user interface", "order": 5, "correct": true},
	{"id": 5, "text": "6. Test and debug", "order": 6, "correct": true},
	{"id": 6, "text": "Skip writing tests to save time", "order": -1, "correct": false},
	{"id": 7, "text": "Code first, plan later", "order": -1, "correct": false},
]

func _ready() -> void:
	setup_challenge()
	submit_button.pressed.connect(_on_submit_pressed)

func setup_challenge() -> void:
	"""Setup the feature implementation challenge"""
	var requirement = """[b]Feature Implementation Challenge[/b]

[b]Client Request:[/b]
\"We need a user registration system for our web application. Users should be able to sign up with email and password, receive a verification email, and log in securely.\"

[b]Your Task:[/b]
Select the correct steps to implement this feature in the proper order. Choose 6 steps that represent a good software development workflow.

[b]Consider:[/b]
• Best practices in software development
• Testing and quality assurance
• Security considerations
• Maintainability"""
	
	requirement_text.text = requirement
	
	# Shuffle steps to make it challenging
	var shuffled_steps = implementation_steps.duplicate()
	shuffled_steps.shuffle()
	
	# Create checkboxes for steps
	for step in shuffled_steps:
		var checkbox = CheckBox.new()
		checkbox.text = step.text
		checkbox.theme_override_font_sizes/font_size = 18
		checkbox.toggled.connect(_on_step_toggled.bind(step.id))
		steps_container.add_child(checkbox)
	
	feedback_label.text = "Select the 6 correct implementation steps"

func _on_step_toggled(toggled_on: bool, step_id: int) -> void:
	"""Handle step selection"""
	if toggled_on:
		if step_id not in selected_steps:
			selected_steps.append(step_id)
	else:
		selected_steps.erase(step_id)
	
	feedback_label.text = "Steps selected: %d" % selected_steps.size()

func _on_submit_pressed() -> void:
	"""Evaluate the answer"""
	if selected_steps.size() == 0:
		feedback_label.text = "Please select at least one step!"
		return
	
	# Check which steps are correct
	var correct_steps = 0
	var incorrect_steps = 0
	
	for step_id in selected_steps:
		var step = implementation_steps[step_id]
		if step.correct:
			correct_steps += 1
		else:
			incorrect_steps += 1
	
	# Calculate score
	var total_correct = 6
	challenge_score = int((float(correct_steps) / float(total_correct)) * 100)
	challenge_score -= incorrect_steps * 10  # Penalty for wrong selections
	challenge_score = max(0, challenge_score)
	
	# Generate feedback
	var feedback = ""
	if correct_steps == total_correct and incorrect_steps == 0:
		feedback = """🎉 Excellent! You've identified the correct development workflow!

[b]Key Points:[/b]
✓ Understanding requirements first is crucial
✓ Test-Driven Development (TDD) improves code quality
✓ Proper planning saves time in the long run
✓ Testing and debugging are essential steps

Your Score: %d/100""" % challenge_score
	else:
		feedback = """Your Score: %d/100

[b]Correct Implementation Order:[/b]
1. Understand requirements and edge cases
2. Design the database schema
3. Write unit tests (TDD approach)
4. Implement the backend API
5. Create the user interface
6. Test and debug

[b]Key Lessons:[/b]
• Never skip testing - it catches bugs early
• Plan before coding - it saves time
• Follow best practices for maintainable code
• Security should be built-in from the start

Correct selections: %d/6
Incorrect selections: %d""" % [challenge_score, correct_steps, incorrect_steps]
	
	feedback_label.text = feedback
	
	# Disable UI
	submit_button.disabled = true
	for child in steps_container.get_children():
		child.disabled = true
	
	# Emit completion
	await get_tree().create_timer(4.0).timeout
	challenge_completed.emit(challenge_score)
