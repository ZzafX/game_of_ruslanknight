extends Node

signal upgrade_available

@onready var timer = $Timer
var next_upgrade_time := 30.0

func get_time_elapsed():
	return timer.wait_time - timer.time_left

func _process(delta):
	var elapsed = get_time_elapsed()
	if elapsed >= next_upgrade_time:
		next_upgrade_time += 30.0
		upgrade_available.emit()
		print("30 секунд — пора выбирать улучшение!")
