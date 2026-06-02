extends Node
var current_money = 0 

func _ready():
	Global.money_collected.connect(on_money_collected)
	
	
func on_money_collected (money):
	current_money += money
	print(current_money)
