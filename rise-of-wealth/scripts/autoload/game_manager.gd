extends Node
## Global game manager for Career Quest
## Tracks player progress, scores, and career completion status

# Career completion tracking
var careers_completed: Dictionary = {
	"software_developer": false,
	"healthcare": false,
	"teacher": false,
	"business_manager": false
}

# Career scores (0-100)
var career_scores: Dictionary = {
	"software_developer": 0,
	"healthcare": 0,
	"teacher": 0,
	"business_manager": 0
}

# Total challenges completed
var total_challenges_completed: int = 0
var total_challenges: int = 12  # 3 challenges per career x 4 careers

# Current career being played
var current_career: String = ""

# Game settings
var sound_enabled: bool = true
var music_volume: float = 0.7

func _ready() -> void:
	print("GameManager initialized")

func complete_career(career_name: String, score: int) -> void:
	"""Mark a career as completed and store the score"""
	if career_name in careers_completed:
		careers_completed[career_name] = true
		career_scores[career_name] = score
		print("Career completed: %s with score: %d" % [career_name, score])

func is_career_completed(career_name: String) -> bool:
	"""Check if a career has been completed"""
	return careers_completed.get(career_name, false)

func get_career_score(career_name: String) -> int:
	"""Get the score for a specific career"""
	return career_scores.get(career_name, 0)

func get_total_completed_careers() -> int:
	"""Get the number of completed careers"""
	var count = 0
	for completed in careers_completed.values():
		if completed:
			count += 1
	return count

func get_overall_score() -> int:
	"""Calculate overall score across all careers"""
	var total = 0
	for score in career_scores.values():
		total += score
	return total / 4  # Average score

func increment_challenges_completed() -> void:
	"""Increment the total challenges completed counter"""
	total_challenges_completed += 1

func reset_progress() -> void:
	"""Reset all game progress"""
	for career in careers_completed.keys():
		careers_completed[career] = false
		career_scores[career] = 0
	total_challenges_completed = 0
	current_career = ""
	print("Game progress reset")

func get_progress_percentage() -> float:
	"""Get overall game progress as percentage"""
	var completed = get_total_completed_careers()
	return (float(completed) / 4.0) * 100.0
