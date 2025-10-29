extends Control
signal challenge_completed(score: int)
var selected: int = -1
@onready var text: RichTextLabel = $VBoxContainer/Panel/RichTextLabel
@onready var opts: VBoxContainer = $VBoxContainer/Options
@onready var fb: Label = $VBoxContainer/Feedback
@onready var btn: Button = $VBoxContainer/Button
func _ready():
text.bbcode_enabled = true
text.text = "[b]Team Leadership[/b]\n\nYour team is demotivated. How do you lead?"
for i in ["Threaten job security", "Understand concerns and provide support", "Ignore and increase pressure", "Micromanage everything"]:
var c = CheckBox.new()
c.text = i
c.toggle_mode = true
c.pressed.connect(func(): selected = opts.get_child_count() - 1 if c.button_pressed else -1; for ch in opts.get_children(): if ch != c: ch.button_pressed = false)
opts.add_child(c)
btn.pressed.connect(func(): if selected != -1: var score = 100 if selected == 1 else 40; fb.text = "Excellent! Empathetic leadership works." if selected == 1 else "Support and understanding motivate teams."; btn.disabled = true; await get_tree().create_timer(2.0).timeout; challenge_completed.emit(score))
