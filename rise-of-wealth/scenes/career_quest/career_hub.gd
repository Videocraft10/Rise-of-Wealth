extends Control
## Career Hub - Career selection screen
## Players choose which career mini-world to explore

@onready var software_dev_button: Button = $CenterContainer/VBoxContainer/GridContainer/SoftwareDevButton
@onready var healthcare_button: Button = $CenterContainer/VBoxContainer/GridContainer/HealthcareButton
@onready var teacher_button: Button = $CenterContainer/VBoxContainer/GridContainer/TeacherButton
@onready var business_button: Button = $CenterContainer/VBoxContainer/GridContainer/BusinessButton
@onready var progress_label: Label = $TopBar/ProgressLabel
@onready var back_button: Button = $TopBar/BackButton

func _ready() -> void:
	# Connect buttons
	software_dev_button.pressed.connect(_on_career_selected.bind("software_developer"))
	healthcare_button.pressed.connect(_on_career_selected.bind("healthcare"))
	teacher_button.pressed.connect(_on_career_selected.bind("teacher"))
	business_button.pressed.connect(_on_career_selected.bind("business_manager"))
	back_button.pressed.connect(_on_back_pressed)
	
	# Update UI with current progress
	update_progress_display()
	update_career_buttons()

func update_progress_display() -> void:
	"""Update the progress label showing completed careers"""
	var completed = GameManager.get_total_completed_careers()
	var total = 4
	var percentage = GameManager.get_progress_percentage()
	progress_label.text = "Progress: %d/%d Careers Completed (%.0f%%)" % [completed, total, percentage]

func update_career_buttons() -> void:
	"""Update button text to show completion status"""
	_update_button_status(software_dev_button, "software_developer", "Software Developer")
	_update_button_status(healthcare_button, "healthcare", "Healthcare Professional")
	_update_button_status(teacher_button, "teacher", "Teacher/Educator")
	_update_button_status(business_button, "business_manager", "Business Manager")

func _update_button_status(button: Button, career_id: String, career_name: String) -> void:
	"""Helper to update individual button status"""
	if GameManager.is_career_completed(career_id):
		var score = GameManager.get_career_score(career_id)
		button.text = "%s\n✓ Completed - Score: %d" % [career_name, score]
		button.modulate = Color(0.7, 1.0, 0.7)  # Green tint
	else:
		button.text = career_name
		button.modulate = Color.WHITE

func _on_career_selected(career_id: String) -> void:
	"""Handle career selection"""
	GameManager.current_career = career_id
	
	# Load the appropriate career scene
	var scene_paths = {
		"software_developer": "res://scenes/careers/software_developer.tscn",
		"healthcare": "res://scenes/careers/healthcare.tscn",
		"teacher": "res://scenes/careers/teacher.tscn",
		"business_manager": "res://scenes/careers/business_manager.tscn"
	}
	
	if career_id in scene_paths:
		get_tree().change_scene_to_file(scene_paths[career_id])
	else:
		push_error("Unknown career: " + career_id)

func _on_back_pressed() -> void:
	"""Return to title screen"""
	get_tree().change_scene_to_file("res://scenes/career_quest/career_quest_title.tscn")
