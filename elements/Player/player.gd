extends CharacterBody2D

const SPEED = 150
const ACCELERATION = 800
const FRICTION = 1250

var health = 100
var max_health = 100

@onready var healthbar = %ProgressBar;

func _process(delta: float) -> void:
	healthbar.value = health
	healthbar.max_value = max_health

func _physics_process(delta: float):
	var vec = Vector2.ZERO
	vec.x = Input.get_axis("move_left", "move_right")
	vec.y = Input.get_axis("move_up", "move_down")
	vec = vec.normalized()

	%sprite.flip_h = vec.x < 0
	
	handle_movement(vec, delta)
	handle_animations(vec)
	
	move_and_slide()


func handle_movement(vec: Vector2, delta: float):
	velocity.x = move_toward(velocity.x, SPEED * vec.x, ACCELERATION * delta)
	velocity.y = move_toward(velocity.y, SPEED * vec.y, ACCELERATION * delta)


func handle_animations(vec: Vector2):
	if vec.length() > 0:
		if %sprite.animation != "Walking": %sprite.animation = "Walking"
	else:
		if %sprite.animation != "Idle": %sprite.animation = "Idle"

func hit(damage: float) -> void:
	health -= damage
	
	if health <= 0:
		die()
	else:
		$HitSound.play()
	
func acelerate(vector: Vector2) -> void:
	print_debug(vector)
	handle_movement(vector, 0.1)
	handle_animations(vector)
	move_and_slide()

func die() -> void:
	$DieSound.play()
	get_parent().remove_child(get_node('.'))
