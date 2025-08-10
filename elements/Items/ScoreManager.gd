extends  Node

var score: int = 0

signal score_changed(new_score: int)

func add_score(amount: int):
	score += amount
	print("Coin")
	emit_signal("score_changed", score)

func reset_score():
	score = 0
	emit_signal("score_changed", score)
