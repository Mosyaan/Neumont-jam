extends CharacterBody2D

const SPEED = 150
const ACCELERATION = 800
const FRICTION = 1250

func _physics_process(delta: float):
	var vec = Vector2.ZERO
	vec.x = Input.get_axis("move_left", "move_right")
	vec.y = Input.get_axis("move_up", "move_down")
	
	
	
	if vec.x > 0: %sprite.flip_h = false
	elif vec.x < 0: %sprite.flip_h = true
	
	handle_movement(vec.normalized(), delta)
	handle_animations(vec)
	
	move_and_slide()


func handle_movement(vec, delta):
	velocity.x = move_toward(velocity.x, SPEED * vec.x, ACCELERATION * delta)
	velocity.y = move_toward(velocity.y, SPEED * vec.y, ACCELERATION * delta)


func handle_animations(vec):
	if vec.x or vec.y:
		if %sprite.animation != "Walking": %sprite.animation = "Walking"
	else:
		if %sprite.animation != "Idle": %sprite.animation = "Idle"
