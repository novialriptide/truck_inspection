extends CharacterBody3D

@export var walking_speed = 6
@export var running_speed = 10
@export var gravity = 10
@export var jump_velocity = 4

@export var camera_sensitivity = 0.002

@export var is_looking_at_interactable = false

@onready var headY = $CameraPivotY
@onready var headX = $CameraPivotY/CameraPivotX
@onready var raycast = $CameraPivotY/CameraPivotX/RayCast3D

@onready var prompt_label = $IndicatorPrompt/HBoxContainer/Label

func on_interact_look_at(interactable: Interactable):
	prompt_label.set_text(interactable.prompt)

func on_interact(interactable: Interactable):
	print(interactable)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		headY.rotate_y(-event.relative.x * camera_sensitivity)
		headX.rotate_x(-event.relative.y * camera_sensitivity)
		
		# Prevent the player from doing cartwheels on the camera.
		headX.rotation.x = clamp(headX.rotation.x, deg_to_rad(-40), deg_to_rad(60))

func _physics_process(delta):
	var is_running = Input.is_action_pressed("move_run")
	var interactable = raycast.get_collider() as Interactable
	is_looking_at_interactable = interactable != null
	var wants_to_interact = Input.is_action_just_pressed("interact_select") and is_looking_at_interactable

	var input_movement = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var head_direction = (headY.transform.basis * Vector3(input_movement.x, 0, input_movement.y)).normalized()

	var speed = running_speed if is_running else walking_speed

	prompt_label.visible = is_looking_at_interactable

	if is_looking_at_interactable:
		on_interact_look_at(interactable)

	if wants_to_interact:
		on_interact(interactable)

	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = jump_velocity

	if head_direction:
		velocity.x = head_direction.x * speed
		velocity.z = head_direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
