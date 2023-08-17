extends SpringArm3D

@onready var parent = $".."
#@onready var default_rotation = $"DefaultRotation"
@onready var model = parent.get_node("Model")
@onready var face_model: MeshInstance3D = model.get_node("RobotArmature/Skeleton3D/Face")

@export var default_height_y: float

@export var position_y_force: int = 2
@export var rotation_y_force: float = 0.4
@export var position_y_heigth: float = 0.5

@export var can_look_back: bool = false
@export var look_back_weight: float = 0.001

@export var mouse_sensibility: float = 0.1

var axis_joy: int = -1
var axis_value: float = 0.0
var camera_velocity: Vector2

var has_controller: int = -1

const JOY_DEADZONE : float = 0.25
const JOY_V_SENS : int = 5 ** 3
const JOY_H_SENS : int = 5 ** 3

func _init():
	has_controller   = Input.get_connected_joypads().size() > 0
func _ready() -> void:
	default_height_y = (parent.position.y + position_y_heigth)
	
func _input(event: InputEvent) -> void:
	# Move Camera With Mouse 
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == 2:
			rotation.y -= deg_to_rad(event.relative.x * mouse_sensibility)
			rotation.x -= deg_to_rad(event.relative.y * mouse_sensibility)
			
		_rotation_body(event)
			
	if event is InputEventJoypadMotion and has_controller:
		if event.get_axis() == JOY_AXIS_RIGHT_X:
			if abs(event.get_axis_value()) > JOY_DEADZONE:
				camera_velocity.y = (-event.get_axis_value() * JOY_H_SENS * get_process_delta_time())
			else:
				camera_velocity.y = 0
		elif event.get_axis() == JOY_AXIS_RIGHT_Y:
			if abs(event.get_axis_value()) > JOY_DEADZONE:
				camera_velocity.x = (-event.get_axis_value() * JOY_V_SENS * get_process_delta_time())
			else:
				camera_velocity.x = 0

func _process(delta: float) -> void:
	rotate_y(deg_to_rad(camera_velocity.y))
	rotation.x += deg_to_rad(camera_velocity.x)
	
	_get_position_of_parent(delta)
	_rotation_coarse(delta)
	
func _get_position_of_parent(_delta: float) -> void:
	position.z = parent.position.z
	position.x = parent.position.x
#	if parent.is_on_floor():
#		position.y = lerp(
#			position.y,
#			default_height_y,
#			delta * position_y_force
#			)
func _rotation_coarse(_delta: float) -> void:
	if can_look_back:
		rotation.y = lerp_angle(rotation.y, model.rotation.y, look_back_weight)
	
func _rotation_body(mouse_event: InputEventMouseMotion) -> void:
	face_model.rotation.y = lerp_angle(face_model.rotation.y, rotation.y, 0.05)
	print(face_model.rotation.y)
	pass
