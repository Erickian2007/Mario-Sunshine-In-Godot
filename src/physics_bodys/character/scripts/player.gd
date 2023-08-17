extends CharacterBody3D
class_name Player

@onready var spring_arm: SpringArm3D = $SpringArm
@onready var model:      Node3D      = $Model

const mass: float = 5.0
const speed: float = 7.0
const jump_force: int = 10

const acel_speed: float = 1.0
const fric_speed: float = 1.0

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
	_rotation_model(delta)
	# functions native
	move_and_slide()

func _apply_gravity(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and can_apply_gravity:
		var gravitational_force: float = (gravity * delta * mass)
		velocity.y -= gravitational_force

func _rotation_model(delta: float) -> void:
	var look_dir = Vector2( -velocity.z ,-velocity.x ).normalized()
	if (velocity.x != 0) or (velocity.z != 0):
		model.rotation.y = lerp_angle(
			model.rotation.y,
			look_dir.angle() ,
			delta * 7
		)

