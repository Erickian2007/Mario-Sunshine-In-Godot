extends RigidBody3D
@export var speed = 0.0
@export var to = Vector3.ZERO:
	set = set_to, get = get_to

var player: CharacterBody3D

var is_on_up: bool

func _ready() -> void:
	gravity_scale = 0
	
func _physics_process(_delta: float) -> void:
	set_axis_velocity(to * speed)
	
#	if is_on_up:
#		var add_inertia: Vector3 = Vector3(linear_velocity.x + player.velocity.x, linear_velocity.y + player.velocity.y, linear_velocity.z + player.)
#
#		player
		
func _on_detection_body_entered(body: Node3D) -> void:
	is_on_up = true
	player   = body
	
func _on_detection_body_exited(_body: Node3D) -> void:
	is_on_up = false
	player   = null

func set_to(value: Vector3) -> void:
	to = value
func get_to() -> Vector3:
	return to
