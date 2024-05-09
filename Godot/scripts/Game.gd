extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Game process can be paused
	process_mode = Node.PROCESS_MODE_PAUSABLE

