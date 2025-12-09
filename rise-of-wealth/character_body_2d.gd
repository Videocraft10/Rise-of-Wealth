extends CharacterBody2D

var speed = 200
var gravity = 900        # Pixels per second squared
var jump_velocity = -400 # Negative because up is negative in Godot

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	# Horizontal input
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = input_vector.x * speed
	
	# Gravity (always pulls down if not on floor)
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0  # Reset vertical velocity when on floor
		
		# Jump
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = jump_velocity
	
	# Move the player
	move_and_slide()
	
	update_animation(input_vector)
	update_flip(input_vector)


func update_animation(input_vector: Vector2):
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")  # Optional jump animation
	elif input_vector.length() > 0:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")


func update_flip(input_vector: Vector2):
	if input_vector.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif input_vector.x > 0:
		$AnimatedSprite2D.flip_h = false
