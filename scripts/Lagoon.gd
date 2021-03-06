##############
# Lagoon.gd
##############

extends Node2D
class_name Lagoon

# The total number of islands
var num_islands : int = 0

# Index of the current island
var current_island : int = 0

onready var islands = get_node("Islands").get_children()
onready var sound = get_node("Sound")

func _ready():
	Main.connect("island_healed", self, "_on_island_healed")
	Main.connect("started_game", self, "_on_started_game")
	
func _on_started_game():
	reset_lagoon_state()
	start_text()
	
func _on_island_healed():
	# Incrementing current island
	current_island += 1
	if current_island < num_islands:
		islands[current_island].make_available()
	else:
		# All islands have been dealt with.
		# End the game.
		Main.is_game_over = true
		sound.play()
		gameover_text()

func reset_lagoon_state():
	num_islands = islands.size()
	current_island = 0
	Main.is_game_over = false
	islands[0].make_available()
	for n in range(1, num_islands):
		islands[n].make_unavailable()
	
func speak(line):
	Main.emit_signal("started_speaking", line)

# Start game script
func start_text():
	var lines = []
	lines.append("The city of Cocoa, Florida, USA. 2048.")
	lines.append("Where... where am I?")
	lines.append("What happened?")
	lines.append("I am the Dryad of the Indian River Lagoon...")
	lines.append("...but I live on the edge of the coastline.")
	lines.append("...now I'm... stuck... on an island?")
	lines.append("...the path around me, underwater?")
	lines.append("Everything here is dead.")
	lines.append("What happened?")
	speak(lines)

# End game script
func gameover_text():
	var lines = []
	lines.append("YES! Yes! I've healed every plant on this loop of islands.")
	lines.append("My powers are exhausted... but with the beginning of an ecosystem, life can return to the lagoon.")
	lines.append("Seagrass, fish, dolphins, manatees...")
	lines.append("The people may be all gone, retreated inland. There are only these tiny islands.")
	lines.append("But for now, the islands can breathe.")
	speak(lines)

