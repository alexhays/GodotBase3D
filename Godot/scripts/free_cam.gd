extends CharacterBody3D


const SPEED = 5.0
var pointerScene = preload("res://scenes/pointer.tscn")
var pointer:CharacterBody3D
@export var pointerMinSize = 1
@export var pointerMaxSize = 1
@export var pointerScaleAmt = 0.1

func _ready():
	pointer = pointerScene.instantiate()
	pointer.visible = false
	add_child(pointer)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		get_viewport().set_input_as_handled()
		$Camera3D.rotate_x(-event.relative.y/300)
		rotate_y(-event.relative.x/300)
	if event is InputEventMouseButton:
		if event.is_action_pressed("scrollUp"):
			get_viewport().set_input_as_handled()
			pointer.scale += Vector3(pointerScaleAmt,pointerScaleAmt,pointerScaleAmt)
		elif event.is_action_pressed("scrollDown"):
			get_viewport().set_input_as_handled()
			pointer.scale -= Vector3(pointerScaleAmt,pointerScaleAmt,pointerScaleAmt)
		if pointer.scale.x<pointerMinSize:
			pointer.scale = Vector3(pointerMinSize,pointerMinSize,pointerMinSize)
		elif pointer.scale.x>pointerMaxSize:
			pointer.scale = Vector3(pointerMaxSize,pointerMaxSize,pointerMaxSize)

func _physics_process(delta):
	if $Camera3D/RayCast3D.is_colliding():
		pointer.visible = true
		pointer.global_position = $Camera3D/RayCast3D.get_collision_point()
	elif pointer.visible:
		pointer.visible = false
		
	print($Camera3D.rotation)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if Input.is_action_pressed("jump"):
		velocity.y = SPEED
	elif Input.is_action_pressed("shift"):
		velocity.y = -SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
