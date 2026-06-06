extends CanvasLayer

signal upgrade_chosen(upgrade: AbilityUpgrade)

@onready var card_container = $HBoxContainer

var offered_upgrades: Array[AbilityUpgrade] = []

func show_upgrades(upgrades: Array[AbilityUpgrade]):
	offered_upgrades = upgrades
	get_tree().paused = true
	visible = true
	
	for i in card_container.get_child_count():
		var btn = card_container.get_child(i)
		if i < upgrades.size():
			btn.text = upgrades[i].name + "\n" + upgrades[i].description
			btn.pressed.connect(_on_card_pressed.bind(i), CONNECT_ONE_SHOT)

func _on_card_pressed(index: int):
	upgrade_chosen.emit(offered_upgrades[index])
	get_tree().paused = false
	visible = false
