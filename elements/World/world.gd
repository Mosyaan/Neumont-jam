extends Node2D

var cooldown_max = 0.5
var time_past = 0
var knonkback_force = 200

func _ready() -> void:
	pass
	
var bodies = {}

func _process(delta: float) -> void:
	for bodyId in bodies:
		var body = bodies[bodyId]
		if body.cooldown > 0: 
			body.cooldown -= delta
		
		if body.cooldown <= 0:
			deal_damage(5, bodyId)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if "hit" in body:
		var bodyId = body.get_instance_id()
		bodies[bodyId] = {
			cooldown = 0,
			node = body
		}

func deal_damage(damage: float, bodyId: int) -> void:
	var body = bodies[bodyId];
	body.node.hit(damage)
	body.cooldown = cooldown_max
	if "acelerate" in body.node:
		var force = $Area2D.global_position.direction_to(body.node.global_position)
		body.node.acelerate(force * knonkback_force)

func _on_area_2d_body_exited(body: Node2D) -> void:
	bodies.erase(body.get_instance_id())
