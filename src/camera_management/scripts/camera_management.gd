extends Area3D

@export var new_position: Vector3 = Vector3.UP
@export var weight: float = 0.1

var arm: SpringArm3D

func _process(delta: float) -> void:
	if arm != null:
		arm.position.y = lerp(arm.position.y, new_position.y, weight * delta)
		
func _on_body_entered(body: Node3D) -> void:
	arm = body.get_node("SpringArm")
	
func _on_body_exited(body: Node3D) -> void:
	arm = null
