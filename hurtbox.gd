extends Area2D
class_name Hurtbox

@export var health_component: HealthComponent

func take_damage(amount):
	if health_component:
		health_component.take_damage(amount)
