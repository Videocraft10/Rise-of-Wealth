extends Control
signal challenge_completed(score: int)
var selected: int = -1
@onready var text: RichTextLabel = $VBoxContainer/Panel/RichTextLabel
@onready var opts: VBoxContainer = $VBoxContainer/Options
@onready var fb: Label = $VBoxContainer/Feedback
@onready var btn: Button = $VBoxContainer/Button
func _ready():
text.bbcode_enabled = true
text.text = "[b]Strategic Decision[/b]\n\nYour company is losing market share. What's your strategy?"
for i in ["Cut all costs immediately", "Analyze data and develop targeted strategy", "Ignore and hope it improves", "Fire random employees"]:
var c = CheckBox.new()
c.text = i
c.toggle_mode = true
c.pressed.connect(func(): selected = opts.get_child_count() - 1 if c.button_pressed else -1; for ch in opts.get_children(): if ch != c: ch.button_pressed = false)
opts.add_child(c)
btn.pressed.connect(func(): if selected != -1: var score = 100 if selected == 1 else 40; fb.text = "Correct! Data-driven strategy is key." if selected == 1 else "Data analysis leads to better decisions."; btn.disabled = true; await get_tree().create_timer(2.0).timeout; challenge_completed.emit(score))
