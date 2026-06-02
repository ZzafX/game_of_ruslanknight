extends Node
class_name HealthComponent

signal died

@export var max_health = 10
var current_health

func _ready():
	current_health = max_health

func take_damage(amount):
	current_health -= amount
	if current_health <= 0:
		died.emit()
		owner.queue_free()

func eck_death():
	if current_health <= 0:
		print("DIED CALLED")
		died.emit()
		owner.queue_free()
