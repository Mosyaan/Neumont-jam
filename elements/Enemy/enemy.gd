extends CharacterBody2D

var health = 50


func _ready() -> void:
	add_to_group("enemies")


func take_damage(amount):
	health -= amount
	print("Enemy took some damage! HP left: ", health)
	if health <= 0:
		queue_free()
