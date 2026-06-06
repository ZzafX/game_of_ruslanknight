extends CharacterBody2D

var max_speed = 50
@onready var health_component: Node = $HealthComponent
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var attack_range = 30.0

func _process(delta: float) -> void:
	var direction = get_direction_to_player()
	var distance = get_distance_to_player()
	
	if distance < attack_range:
		velocity = Vector2.ZERO
		update_animation(direction, true)
	else:
		velocity = max_speed * direction
		update_animation(direction, false)
	
	move_and_slide()

func get_direction_to_player():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player != null:
		return (player.global_position - self.global_position).normalized()
	return Vector2.ZERO

func get_distance_to_player():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player != null:
		return global_position.distance_to(player.global_position)
	return INF

func update_animation(direction: Vector2, is_attacking: bool):
	if direction.x < 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
	
	if is_attacking:
		animated_sprite.play("attack")
	else:
		animated_sprite.play("run")
		
