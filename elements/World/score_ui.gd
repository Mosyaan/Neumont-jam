extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		ScoreManager.connect("score_changed", Callable(self, "_on_score_changed"))
		_on_score_changed(ScoreManager.score)
	
	
func _on_score_changed(new_score: int):
	$Label.text = "Score: %d" % new_score
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
