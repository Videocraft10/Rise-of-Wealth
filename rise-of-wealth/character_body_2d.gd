extends CharacterBody2D

@export var walk_speed: float = 200.0
@export var sprint_speed: float = 400.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	var direction := Vector2.ZERO

	# --- Movement input ---
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	# --- Sprint check ---
	var speed := walk_speed
	if Input.is_action_pressed("shift"):
		speed = sprint_speed

	# --- Normalize and move ---
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	# --- Optional: Flip sprite based on direction ---
	if sprite:
		if direction.x != 0:
			sprite.flip_h = direction.x < 0
