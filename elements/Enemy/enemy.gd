extends CharacterBody2D

var health = 30


func _ready() -> void:
	add_to_group("enemies")


func take_damage(amount):
	$AnimatedSprite2D.play("took_damage")
	health -= amount
	print("Enemy took some damage! HP left: ", health)
	if health <= 0:
		die()


func die():
	var coin_scene = preload("res://elements/Items/coin_bit.tscn")
	var coin_instance = coin_scene.instantiate()
	coin_instance.global_position = global_position
	get_tree().current_scene.add_child(coin_instance)
	
	queue_free()
