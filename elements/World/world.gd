extends Node2D

var backgroundMusic: AudioStreamPlayer = Global.get_node("CalmAmbient")
var gameMusic: AudioStreamPlayer = Global.get_node("GameAmbient")

var cooldown_max = 2
var time_past = 0
var knonkback_force = 200

func _ready() -> void:
	pass


	
var bodies: Dictionary[int, Dictionary] = {}

func _process(delta: float) -> void:
	if !gameMusic.playing:
		backgroundMusic.stop()
		gameMusic.play()
	
	for bodyId in bodies:
		var body = bodies[bodyId]
		if body.cooldown > 0: 
			body.cooldown -= delta
		
		if body.cooldown <= 0 and body.entered:
			if body.entered:
				deal_damage(5, bodyId)
			else:
				bodies.erase(bodyId)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is LivingEntity:
		var bodyId = body.get_instance_id()
		
		if bodyId in bodies:
			bodies[body.get_instance_id()].entered = true
		else:
			bodies[bodyId] = {
				cooldown = 0,
				entered = true,
				node = body
			}

func deal_damage(damage: float, bodyId: int) -> void:
	var body = bodies[bodyId]
	print_debug(%LivingEntity.get_collision_center())
	(body.node as LivingEntity).hit_by_entity(5, %LivingEntity)
	body.cooldown = cooldown_max

func _on_area_2d_body_exited(body: Node2D) -> void:
	bodies[body.get_instance_id()].entered = false


func _input(event: InputEvent):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
