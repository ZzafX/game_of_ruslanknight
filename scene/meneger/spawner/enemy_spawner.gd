extends Node


@export var Orc_scene: PackedScene

func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var random_distence = randi_range(380, 500)
	var spawn_pos = player.global_position + (random_direction * random_distence)
	
	var enemy = Orc_scene.instantiate() as Node2D
	get_parent().add_child(enemy)
	
	enemy.global_position = spawn_pos
