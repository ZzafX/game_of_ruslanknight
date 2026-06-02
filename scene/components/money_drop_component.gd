extends Node

@export var money_scene: PackedScene

@onready var health_component: HealthComponent = get_parent().get_node("HealthComponent")


func _ready():
	health_component.died.connect(on_died)


func on_died():
	# 50% шанс
	if randf() > 0.5:
		return

	call_deferred("spawn_money")


func spawn_money():
	var money = money_scene.instantiate()
	get_tree().current_scene.add_child(money)
	money.global_position = get_parent().global_position
