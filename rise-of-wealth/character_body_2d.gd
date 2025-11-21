extends CharacterBody2D

var speed = 200

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	# Get WASD / arrow key input
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# Normalize vector for diagonal movement
	input_vector = input_vector.normalized()
	
	# Move the player
	velocity = input_vector * speed
	move_and_slide()
	
	update_animation(input_vector)
	update_flip(input_vector)


func update_animation(input_vector: Vector2):
	if input_vector.length() > 0:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")


func update_flip(input_vector: Vector2):
	if input_vector.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif input_vector.x > 0:
		$AnimatedSprite2D.flip_h = false
