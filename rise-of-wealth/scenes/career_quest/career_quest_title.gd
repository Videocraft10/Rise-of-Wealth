extends Control
## Career Quest Title Screen
## Main menu for the Career Quest game

@onready var start_button: Button = $VBoxContainer/StartButton
@onready var instructions_button: Button = $VBoxContainer/InstructionsButton
@onready var credits_button: Button = $VBoxContainer/CreditsButton
@onready var quit_button: Button = $VBoxContainer/QuitButton
@onready var instructions_panel: Panel = $InstructionsPanel
@onready var close_instructions_btn: Button = $InstructionsPanel/VBoxContainer/CloseButton

func _ready() -> void:
	# Hide instructions panel initially
	if instructions_panel:
		instructions_panel.hide()
	
	# Connect button signals
	start_button.pressed.connect(_on_start_button_pressed)
	instructions_button.pressed.connect(_on_instructions_button_pressed)
	credits_button.pressed.connect(_on_credits_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	if close_instructions_btn:
		close_instructions_btn.pressed.connect(_on_close_instructions_pressed)

func _on_start_button_pressed() -> void:
	# Load career selection hub
	get_tree().change_scene_to_file("res://scenes/career_quest/career_hub.tscn")

func _on_instructions_button_pressed() -> void:
	if instructions_panel:
		instructions_panel.show()

func _on_close_instructions_pressed() -> void:
	if instructions_panel:
		instructions_panel.hide()

func _on_credits_button_pressed() -> void:
	# Show credits dialog
	var dialog = AcceptDialog.new()
	dialog.dialog_text = """Career Quest - A Career Exploration Game
	
Created for FBLA 2025-2026 Competition
Computer Game & Simulation Programming

Developed using Godot Engine 4.5
Programming Language: GDScript

Game Design: Career exploration through interactive mini-worlds
Each career features unique challenges and scenarios

© 2025 Rise of Wealth Team"""
	dialog.title = "About Career Quest"
	dialog.dialog_autowrap = true
	add_child(dialog)
	dialog.popup_centered()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
