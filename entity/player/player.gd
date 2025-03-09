extends CharacterBody3D

@export var walking_speed = 6
@export var running_speed = 10
@export var gravity = 10
@export var jump_velocity = 4

@export var camera_sensitivity = 0.002

@onready var head = $CameraPivot
@onready var camera = $CameraPivot/Camera3D
@onready var raycast = $CameraPivot/RayCast3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * camera_sensitivity)
		camera.rotate_x(-event.relative.y * camera_sensitivity)
		
		# Prevent the player from doing cartwheels on the camera.
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = jump_velocity

	var input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (head.transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	var is_running = Input.is_action_pressed("move_run")

	var speed = running_speed if is_running else walking_speed


	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
