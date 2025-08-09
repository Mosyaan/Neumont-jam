extends CharacterBody2D


const SPEED = 150
const ACCELERATION = 800
const FRICTION = 1250

# @onready var animated_sprite2d = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	
	var vec = Vector2.ZERO
	
	vec.x = Input.get_axis("ui_left", "ui_right")
	vec.y = Input.get_axis("ui_up", "ui_down")
	
	handle_movement(vec.normalized(), delta)

	move_and_slide()


func handle_movement(vec, delta):
	
	velocity.x = move_toward(velocity.x, SPEED * vec.x, ACCELERATION * delta)
	
	velocity.y = move_toward(velocity.y, SPEED * vec.y, ACCELERATION * delta)
