extends  Node

var score: int = 0

func _process(delta: float):
	if score >= 25:
		get_tree().change_scene_to_file("res://scenes/game_oveer.tscn")

signal score_changed(new_score: int)

func add_score(amount: int):
	score += amount
	print("Coin")
	emit_signal("score_changed", score)

func reset_score():
	score = 0
	emit_signal("score_changed", score)
