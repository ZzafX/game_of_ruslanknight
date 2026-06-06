extends Node
class_name UpgradeManager

@export var arena_time_manager: Node
@export var upgrades: Array[AbilityUpgrade] = []
@export var upgrade_ui: CanvasLayer
@export var player: CharacterBody2D

func _ready():
	arena_time_manager.upgrade_available.connect(offer_upgrades)
	upgrade_ui.upgrade_chosen.connect(apply_upgrade)

func offer_upgrades():
	if upgrades.is_empty():
		print("Нет доступных улучшений!")
		return
	
	var pool = upgrades.duplicate()
	pool.shuffle()
	var offered: Array[AbilityUpgrade] = []
	for i in min(3, pool.size()):
		offered.append(pool[i])
	
	upgrade_ui.show_upgrades(offered)

func apply_upgrade(upgrade: AbilityUpgrade):
	match upgrade.id:
		"sword_rate":
			player.attack_speed *= 1.1
			print("Скорость атаки увеличена! Текущая: ", player.attack_speed)
