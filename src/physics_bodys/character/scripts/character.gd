extends CharacterBody3D

@onready var spring_arm: SpringArm3D = $SpringArm
@onready var model:      Node3D      = $Model

@export var mass:          int = 2.0
@export var speed:         int = 7.0
@export var jump_velocity: int = 10

@export var acel_speed: float = 1.0
@export var fric_speed: float = 1.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var can_apply_gravity: bool = true 
var can_slide_ramp:    bool = false
var can_move:          bool = true
var can_jump:          bool = true

var was_sliding:    bool = false
var is_sliding:     bool = false

func _ready() -> void:
	Global.player = self

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_move_and_impulse()
	_rotation_model(delta)
	#_slide_ramp()
	# functions native
	apply_floor_snap()
	move_and_slide()

func _apply_gravity(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and can_apply_gravity:
		var gravitational_force: float = (gravity * delta * mass)
		velocity.y -= gravitational_force

func _move_and_impulse() -> void:
	# Handle Jump.
	var pressed: bool = Input.is_action_just_pressed("jump")
	if pressed and is_on_floor() and can_jump:
		velocity.y = jump_velocity
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir: Vector3 = Vector3.ZERO
	input_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_dir.z = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_dir = input_dir.rotated(Vector3.UP, spring_arm.rotation.y).normalized()
	
	if can_move:
		if input_dir:
			velocity.x = lerp(velocity.x,  input_dir.x * speed, acel_speed)
			velocity.z = lerp(velocity.z, input_dir.z * speed, acel_speed)
			
		else:
			velocity.x = move_toward(velocity.x, 0, fric_speed)
			velocity.z = move_toward(velocity.z, 0, fric_speed)

func _rotation_model(delta: float) -> void:
	var look_dir = Vector2( -velocity.z ,-velocity.x ).normalized()
	if (velocity.x != 0) or (velocity.z != 0):
		model.rotation.y = lerp_angle(
			model.rotation.y,
			look_dir.angle() ,
			delta * 7
		)
		pass
#
#func _slide_ramp() -> void:
#	var get_last_slop: Vector3
#	var slide:         Vector3 
#
#	const force:  int = 10
#	const weight: float = 1.0
#
#	# getting last motion of the slope
#	if get_last_motion().length() != 0: get_last_slop = get_last_motion()
#
#	# checking if can slide
#	if can_slide_ramp:
#		slide = Vector3((velocity.x - get_last_slop.x) * 50, 0, (velocity.z - get_last_slop.z) * 50).normalized()
#
#		velocity    = lerp(velocity, slide * force, weight)
#		velocity.y -= 20
#
#		is_sliding = true
#
#		print(velocity)
#
#	elif was_sliding:
#		pass
#
