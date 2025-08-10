extends Area2D

@export var value: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	# start animation
	$AnimatedSprite2D.play("spin")


func _on_body_entered(body):
	if body.is_in_group("player"):
		ScoreManager.add_score(5)
		queue_free()
