extends RigidBody3D

@onready var animation = $"Animation"

@export var speed = 0.0
@export var loop_rotation = false
@export var ninety_degreess = false

enum {  # index #
	ZERO, # 0
	UP,   # 1
	DOWN, # 2
	LEFT, # 3
	RIGHT # 4 
	}

var current_state = RIGHT:
	set = set_current_state, 
	get = get_current_state

func _ready() -> void:
	gravity_scale = 0
	
func _physics_process(delta: float) -> void:
	match current_state:
		ZERO:
			set_axis_velocity(Vector3.ZERO)
		UP:
			set_axis_velocity(Vector3.UP * speed)
			axis_lock_linear_x = true
			axis_lock_linear_z = true
			axis_lock_linear_y = false
		DOWN:
			set_axis_velocity(Vector3.DOWN * speed)
			axis_lock_linear_x = true
			axis_lock_linear_z = true
			axis_lock_linear_y = false
		LEFT:
			set_axis_velocity(Vector3.LEFT * speed)
			axis_lock_linear_x = false
			axis_lock_linear_z = true
			axis_lock_linear_y = true
		RIGHT:
			set_axis_velocity(Vector3.RIGHT * speed)
			axis_lock_linear_x = false
			axis_lock_linear_z = true
			axis_lock_linear_y = true
		
	play_rotation_loop()
	
func set_current_state(value):
	current_state = value
	
func get_current_state():
	return current_state
	
func play_90_degrees():
	if ninety_degreess:
		animation.play("90_degrees")
		
func play_rotation_loop():
	if loop_rotation:
		rotation.y += 1 * speed
