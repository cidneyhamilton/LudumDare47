##############
# Title.gd
##############

extends CanvasLayer

onready var container = get_node("Container")

# Called to bring the title screen back up after the game is finished
func _on_finished_game():
	container.show()

# Handle button presses
func _on_StartButton_pressed():
	print("Started game")
	container.hide()
	Main.emit_signal("started_game")
	
func _on_SettingsButton_pressed():
	Main.emit_signal("show_settings")

func _on_QuitButton_pressed():
	get_tree().quit()
