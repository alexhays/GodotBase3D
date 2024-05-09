extends Node3D

var menuOpen = true

# Called when the node enters the scene tree for the first time.
func _ready():
	# This process can not be paused
	process_mode = Node.PROCESS_MODE_ALWAYS
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Menu.visible = menuOpen
	$Game.get_tree().paused = menuOpen
	if menuOpen:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	# if keyevent and action is menu
	if event is InputEventKey and event.is_action_released("menu"):
		menuOpen = not menuOpen
		$Menu.visible = menuOpen
		$Game.get_tree().paused = menuOpen
		if menuOpen:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
