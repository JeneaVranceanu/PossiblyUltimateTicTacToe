extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_PlayerButton_pressed():
	Global.choose_player_game_type()


func _on_ComputerButton_pressed():
	Global.start_new_game()
