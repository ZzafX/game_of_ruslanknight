extends Node2D

@export var money_experience := 1

@onready var area: Area2D = $Area2D


func _ready():
	area.body_entered.connect(_on_body_entered)
	area.area_entered.connect(_on_area_entered)


func _on_area_entered(other_area: Area2D) -> void:
	collect()


func _on_body_entered(body: Node2D) -> void:
	collect()


func collect():
	Global.money_collected.emit(money_experience)
	queue_free()
