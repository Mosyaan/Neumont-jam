extends CharacterBody2D

const SPEED = 100
const ACCELERATION = 800
const FRICTION = 1250

var last_direction := "down"
var is_attacking := false
var health := 100
var bits := 0

@onready var sprite: AnimatedSprite2D = %sprite
@onready var attack_area: Area2D = $Area2D




func _ready():
	attack_area.connect("body_entered", Callable(self, "_on_attack_body_entered"))
	attack_area.monitoring = false


func _physics_process(delta: float):
	var vec = Vector2.ZERO
	
	if not is_attacking:
		vec.x = Input.get_axis("move_left", "move_right")
		vec.y = Input.get_axis("move_up", "move_down")
	
	if Input.is_action_just_pressed("attack"):
		start_attack()

	handle_movement(vec.normalized(), delta)
	handle_movement_animations(vec)

	move_and_slide()


func handle_movement(vec: Vector2, delta: float):
	velocity.x = move_toward(velocity.x, SPEED * vec.x, ACCELERATION * delta)
	velocity.y = move_toward(velocity.y, SPEED * vec.y, ACCELERATION * delta)


func handle_movement_animations(vec: Vector2):
	if is_attacking:
		return

	if vec != Vector2.ZERO:
		# Определяем направление
		if abs(vec.x) > abs(vec.y):
			if vec.x > 0:
				sprite.play("Walking_right")
				last_direction = "right"
			else:
				sprite.play("Walking_left")
				last_direction = "left"
		else:
			if vec.y > 0:
				sprite.play("Walking_down")
				last_direction = "down"
			else:
				sprite.play("Walking_up")
				last_direction = "up"
	else:
		sprite.play("Idle_%s" % last_direction)


func start_attack():
	update_attack_position()
	is_attacking = true
	sprite.play("Attack_%s" % last_direction)
	attack_area.monitoring = true
	
	await sprite.animation_finished
	attack_area.monitoring = false
	is_attacking = false


func update_attack_position():
	match last_direction:
		"right": attack_area.position = Vector2(16, 0)
		"left": attack_area.position = Vector2(-16, 0)
		"up": attack_area.position = Vector2(0, -16)
		"down": attack_area.position = Vector2(0, 16)


func _on_attack_body_entered(body):
	if body.is_in_group("enemies"):
		if body.has_method("take_damage"):
			body.take_damage(10)
