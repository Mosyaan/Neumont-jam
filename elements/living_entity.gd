class_name LivingEntity extends CharacterBody2D

signal recieve_damage
signal health_below_zero
signal peform_movement

@export
var health = 100
@export
var max_health = 100
@export
var collision_center: Vector2
@export
var knockback_raito = 0.8
@export
var healthbar_top: int

# Returns global collision center
func get_collision_center() -> Vector2:
	return global_position + collision_center

func hit(damage: float) -> void:
	health -= damage
	recieve_damage.emit()
	
	if health <= 0:
		health_below_zero.emit()

func hit_by_entity(damage: float, entity: LivingEntity) -> void:
	hit(damage)
	var knockback = entity.get_collision_center().direction_to(get_collision_center())
	knockback *= damage / max_health * knockback_raito * 100000
	handle_movement(knockback)

func handle_movement(vector: Vector2):
	velocity = vector
	peform_movement.emit(velocity)
	move_and_slide()
