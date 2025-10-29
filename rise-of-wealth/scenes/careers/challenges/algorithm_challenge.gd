extends Control
## Algorithm Challenge - Solve an algorithmic problem
## Part of Software Developer career

signal challenge_completed(score: int)

var challenge_score: int = 0
var time_taken: float = 0.0
var timer_running: bool = false

@onready var problem_text: RichTextLabel = $VBoxContainer/ProblemPanel/ProblemText
@onready var option_buttons: VBoxContainer = $VBoxContainer/OptionsContainer
@onready var feedback_label: Label = $VBoxContainer/FeedbackLabel
@onready var timer_label: Label = $VBoxContainer/TopBar/TimerLabel
@onready var submit_button: Button = $VBoxContainer/SubmitButton

var correct_answer: int = 2  # Index of correct answer
var selected_answer: int = -1

var options = [
	"O(n²) - Using nested loops",
	"O(n log n) - Using quicksort then iteration",
	"O(n) - Using a hash map for single pass",
	"O(2^n) - Using recursion with no memoization"
]

func _ready() -> void:
	setup_challenge()
	submit_button.pressed.connect(_on_submit_pressed)
	start_timer()

func setup_challenge() -> void:
	"""Setup the algorithm challenge"""
	var problem = """[b]Algorithm Challenge: Two Sum Problem[/b]

[b]Problem:[/b]
Given an array of integers and a target sum, find two numbers in the array that add up to the target. Return their indices.

Example:
Input: nums = [2, 7, 11, 15], target = 9
Output: [0, 1] (because nums[0] + nums[1] = 2 + 7 = 9)

[b]Your Task:[/b]
Which algorithmic approach provides the most efficient solution (best time complexity)?

[b]Consider:[/b]
• Time complexity
• Space trade-offs
• Scalability for large datasets"""
	
	problem_text.text = problem
	
	# Create option buttons
	for i in range(options.size()):
		var radio = CheckBox.new()
		radio.text = options[i]
		radio.theme_override_font_sizes/font_size = 18
		radio.toggle_mode = true
		radio.pressed.connect(_on_option_selected.bind(i))
		option_buttons.add_child(radio)
	
	feedback_label.text = "Select the best algorithmic approach"

func start_timer() -> void:
	"""Start the challenge timer"""
	timer_running = true
	time_taken = 0.0

func _process(delta: float) -> void:
	if timer_running:
		time_taken += delta
		timer_label.text = "Time: %.1fs" % time_taken

func _on_option_selected(option_index: int) -> void:
	"""Handle option selection (radio button behavior)"""
	selected_answer = option_index
	
	# Uncheck other options
	var children = option_buttons.get_children()
	for i in range(children.size()):
		if i != option_index:
			children[i].button_pressed = false

func _on_submit_pressed() -> void:
	"""Evaluate the answer"""
	if selected_answer == -1:
		feedback_label.text = "Please select an answer!"
		return
	
	timer_running = false
	
	# Base score
	var base_score = 100
	
	# Calculate score based on correctness and time
	if selected_answer == correct_answer:
		# Bonus for speed: max 20 points bonus, decreases with time
		var time_bonus = max(0, 20 - int(time_taken / 2))
		challenge_score = min(100, base_score + time_bonus)
		
		feedback_label.text = """✅ Correct!

O(n) using a hash map is the optimal solution.

[b]Explanation:[/b]
• Single pass through the array
• Hash map stores seen numbers and their indices
• Lookup in hash map is O(1) on average
• Total time complexity: O(n)
• Space complexity: O(n) for the hash map

This is much better than O(n²) brute force!

Your Score: %d/100
Time Taken: %.1f seconds""" % [challenge_score, time_taken]
	else:
		challenge_score = 40  # Partial credit for attempting
		
		var explanation = ""
		if selected_answer == 0:
			explanation = "Nested loops would work but are inefficient (O(n²))."
		elif selected_answer == 1:
			explanation = "Sorting first would be O(n log n), better than O(n²) but not optimal."
		elif selected_answer == 3:
			explanation = "O(2^n) recursion would be extremely slow for this problem."
		
		feedback_label.text = """❌ Not quite right.

%s

The correct answer is: O(n) using a hash map.

This gives the best time complexity for the Two Sum problem.

Your Score: %d/100
Time Taken: %.1f seconds""" % [explanation, challenge_score, time_taken]
	
	# Disable UI
	submit_button.disabled = true
	for child in option_buttons.get_children():
		child.disabled = true
	
	# Emit completion
	await get_tree().create_timer(4.0).timeout
	challenge_completed.emit(challenge_score)
