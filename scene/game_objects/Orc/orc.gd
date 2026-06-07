extends CharacterBody2D

var max_speed = 50
@onready var health_component: Node = $HealthComponent
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var attack_range = 30.0
var attack_damage = 1
var is_attacking = false

func _process(delta: float) -> void:
	var direction = get_direction_to_player()
	var distance = get_distance_to_player()
	
	if distance < attack_range and not is_attacking:
		velocity = Vector2.ZERO
		if animated_sprite.animation != "attack":
			animated_sprite.play("attack")
	elif not is_attacking:
		velocity = max_speed * direction
		update_animation(direction)
	
	move_and_slide()

func _on_hitbox_area_entered(area: Area2D):
	if area is Hurtbox:
		area.take_damage(attack_damage)

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

func update_animation(direction: Vector2):
	if direction == Vector2.ZERO:
		return
	if direction.x < 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
	animated_sprite.play("run")
