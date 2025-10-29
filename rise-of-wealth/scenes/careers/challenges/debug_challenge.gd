extends Control
## Debug Challenge - Find and fix code errors
## Part of Software Developer career

signal challenge_completed(score: int)

var bugs_found: int = 0
var total_bugs: int = 3
var challenge_score: int = 0

@onready var code_display: RichTextLabel = $VBoxContainer/CodePanel/CodeDisplay
@onready var bug_buttons_container: VBoxContainer = $VBoxContainer/BugButtonsContainer
@onready var feedback_label: Label = $VBoxContainer/FeedbackLabel
@onready var submit_button: Button = $VBoxContainer/SubmitButton

# Bug locations (line numbers in code)
var bug_data = [
	{"line": 5, "description": "Line 5: Missing semicolon", "correct": true},
	{"line": 8, "description": "Line 8: Wrong comparison operator (= instead of ==)", "correct": true},
	{"line": 12, "description": "Line 12: Variable typo (cnt instead of count)", "correct": true},
	{"line": 3, "description": "Line 3: Function name is misspelled", "correct": false},
	{"line": 10, "description": "Line 10: Loop condition is correct", "correct": false},
]

var selected_bugs: Array = []

func _ready() -> void:
	setup_challenge()
	submit_button.pressed.connect(_on_submit_pressed)

func setup_challenge() -> void:
	"""Setup the debugging challenge"""
	# Display buggy code
	var buggy_code = """[b]Challenge: Find the bugs in this code[/b]

[color=gray]1:[/color] function calculateTotal(items) {
[color=gray]2:[/color]     let total = 0;
[color=gray]3:[/color]     let count = 0;
[color=gray]4:[/color]     
[color=gray]5:[/color]     for (let i = 0; i < items.length; i++) [color=red]// Bug here![/color]
[color=gray]6:[/color]         total += items[i].price;
[color=gray]7:[/color]         count++;
[color=gray]8:[/color]         if (count = 10) {  [color=red]// Bug here![/color]
[color=gray]9:[/color]             break;
[color=gray]10:[/color]        }
[color=gray]11:[/color]    }
[color=gray]12:[/color]    return total / cnt;  [color=red]// Bug here![/color]
[color=gray]13:[/color] }

[b]Your task:[/b] Identify all 3 bugs in this JavaScript function."""
	
	code_display.text = buggy_code
	
	# Create bug selection buttons
	for i in range(bug_data.size()):
		var bug_button = CheckBox.new()
		bug_button.text = bug_data[i].description
		bug_button.theme_override_font_sizes/font_size = 18
		bug_button.toggled.connect(_on_bug_toggled.bind(i))
		bug_buttons_container.add_child(bug_button)
	
	feedback_label.text = "Select the bugs you've found (3 total)"

func _on_bug_toggled(toggled_on: bool, bug_index: int) -> void:
	"""Handle bug selection"""
	if toggled_on:
		if bug_index not in selected_bugs:
			selected_bugs.append(bug_index)
	else:
		selected_bugs.erase(bug_index)
	
	# Update feedback
	feedback_label.text = "Bugs selected: %d/3" % selected_bugs.size()

func _on_submit_pressed() -> void:
	"""Evaluate the answer"""
	if selected_bugs.size() == 0:
		feedback_label.text = "Please select at least one bug!"
		return
	
	# Calculate score
	var correct_bugs = 0
	var incorrect_selections = 0
	
	for bug_index in selected_bugs:
		if bug_data[bug_index].correct:
			correct_bugs += 1
		else:
			incorrect_selections += 1
	
	# Score calculation: 100 points max, -20 for each mistake
	challenge_score = 100
	challenge_score -= (total_bugs - correct_bugs) * 20  # Missed bugs
	challenge_score -= incorrect_selections * 20  # False positives
	challenge_score = max(0, challenge_score)
	
	# Show feedback
	var feedback = ""
	if correct_bugs == total_bugs and incorrect_selections == 0:
		feedback = "🎉 Perfect! You found all the bugs!\n"
	elif correct_bugs == total_bugs:
		feedback = "Good! You found all bugs, but selected some false positives.\n"
	else:
		feedback = "You found %d out of %d bugs.\n" % [correct_bugs, total_bugs]
	
	feedback += "Score: %d/100\n\n" % challenge_score
	feedback += "[b]Correct bugs:[/b]\n"
	feedback += "• Line 5: Missing opening brace { after for loop\n"
	feedback += "• Line 8: Assignment = used instead of comparison ==\n"
	feedback += "• Line 12: Variable 'cnt' undefined (should be 'count')"
	
	feedback_label.text = feedback
	
	# Disable buttons
	submit_button.disabled = true
	for child in bug_buttons_container.get_children():
		child.disabled = true
	
	# Emit completion after delay
	await get_tree().create_timer(3.0).timeout
	challenge_completed.emit(challenge_score)
