extends Node
var current_money = 0 

func _ready():
	Global.money_collected.connect(on_money_collected)
	
func on_money_collected(amount):
	current_money += amount
	print(current_money)
