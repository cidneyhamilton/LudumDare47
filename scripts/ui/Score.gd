##############
# Score.gd
##############

extends Control

var value : int = 0
var max_value : int = 0

onready var label = get_node("Container/Label")

func _ready() -> void:
	Main.connect("plant_resurrected", self, "_on_plant_resurrected")
	Main.connect("started_game", self, "set_init_score")
	
func _on_plant_resurrected() -> void:
	update_score()

# Set the initial score and max score values
func set_init_score() -> void:
	value = 0
	if max_value == 0:
		max_value = get_tree().get_nodes_in_group("plants").size()
	update_score_label()
	
func update_score() -> void:
	value += 1
	update_score_label()
	# TODO: End the game if reached max score

func update_score_label() -> void:
	label.text = "Score: " + str(value) + " out of " + str(max_value)
	
func _on_Back_pressed() -> void:
	sfx()
	Main.emit_signal("finished_game")
	
# Play a button effect
func sfx() -> void:	
	Main.emit_signal("play_sfx", "button-press")
