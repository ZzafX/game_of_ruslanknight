extends CanvasLayer

var coins := 0
var label: Label

func _ready():
	label = find_child("Label", true, false)

	if label == null:
		print(" Label not found in scene tree")
		return

	Global.money_collected.connect(_on_money_collected)
	label.text = "0"

func _on_money_collected(amount):
	coins += amount
	label.text = str(coins)
