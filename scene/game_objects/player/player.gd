extends CharacterBody2D

var max_speed = 200
var acceleration = 0.2
var attack_speed = 1.0
var is_attacking = false
var facing = "right"

func _physics_process(delta):
	var movement = movement_vector()
	var direction = movement.normalized()
	var speed = max_speed * 0.6 if is_attacking else max_speed
	var target_velocity = speed * direction
	velocity = velocity.lerp(target_velocity, acceleration)
	move_and_slide()
	update_facing(movement)
	update_animation(movement)
	
	if Input.is_action_just_pressed("attack") and not is_attacking:
		start_attack()

func movement_vector():
	var movement_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var movement_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(movement_x, movement_y)

func update_facing(movement: Vector2):
	if movement.length() < 0.1:
		return
	if abs(movement.x) > abs(movement.y):
		facing = "right" if movement.x > 0 else "left"
	else:
		facing = "down" if movement.y > 0 else "up"

func update_animation(movement: Vector2):
	if is_attacking:
		return
	if movement.length() > 0.1:
		$AnimatedSprite2D.play("run_" + facing)
	else:
		$AnimatedSprite2D.play("idle_" + facing)

func get_facing_to_mouse():
	var mouse_pos = get_global_mouse_position()
	var diff = mouse_pos - global_position
	if abs(diff.x) > abs(diff.y):
		return "right" if diff.x > 0 else "left"
	else:
		return "down" if diff.y > 0 else "up"

func start_attack():
	is_attacking = true
	$Hitbox.monitoring = false
	var mouse_pos = get_global_mouse_position()
	var diff = (mouse_pos - global_position).normalized()
	$Hitbox.position = diff * 40
	var attack_facing = get_facing_to_mouse()
	$AnimatedSprite2D.speed_scale = attack_speed
	$AnimatedSprite2D.play("attack_" + attack_facing)

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation.begins_with("attack"):
		$AnimatedSprite2D.speed_scale = 1.0
		$AnimatedSprite2D.play("idle_" + facing)
		$Hitbox.monitoring = false
		is_attacking = false

func _ready():
	$Hitbox.monitoring = false
	$AnimatedSprite2D.connect("frame_changed", _on_frame_changed)
	$AnimatedSprite2D.connect("animation_finished", _on_animated_sprite_2d_animation_finished)

func _on_frame_changed():
	if not $AnimatedSprite2D.animation.begins_with("attack"):
		return
	var frame = $AnimatedSprite2D.frame
	if frame == 1 or frame == 2 or frame == 9 or frame == 10:
		$Hitbox.monitoring = true
	else:
		$Hitbox.monitoring = false

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		area.take_damage(5)
