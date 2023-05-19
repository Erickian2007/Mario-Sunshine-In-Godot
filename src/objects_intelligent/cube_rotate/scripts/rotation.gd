extends RigidBody3D

@export var speed: float
@export var can_rotate_y: bool = false
@export var can_rotate_x: bool = false
@export var can_rotate_z: bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if can_rotate_x: apply_torque(Vector3.LEFT * speed * delta)
	if can_rotate_y: apply_torque(Vector3.UP * speed * delta)
	if can_rotate_z: apply_torque(Vector3.FORWARD * speed * delta)
