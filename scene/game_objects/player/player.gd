extends CharacterBody2D

var max_speed = 200
var acceleration = 0.2

func _physics_process(delta):
	var movement = movement_vector()
	var direction = movement.normalized()
	var target_velocity = max_speed * direction

	velocity = velocity.lerp(target_velocity, acceleration)
	move_and_slide()

func movement_vector():
	var movement_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var movement_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	return Vector2(movement_x, movement_y)


func _on_timer_timeout():
	$AnimatedSprite2D.play("attack")

	await get_tree().create_timer(0.35).timeout

	$Hitbox.monitoring = true

	await get_tree().create_timer(0.08).timeout

	$Hitbox.monitoring = false


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "attack":
		$AnimatedSprite2D.play("idle")
func _ready():
	$Hitbox.monitoring = false


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		area.take_damage(5)
