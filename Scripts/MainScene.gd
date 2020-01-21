extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_New_Game_Button_pressed():
	Global.start_new_game()


func _on_Settings_Button_pressed():
	print('Settings button pressed')


func _on_Exit_Button_pressed():
	get_tree().quit()
