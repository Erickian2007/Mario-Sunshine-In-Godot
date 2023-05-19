extends RigidBody3D

var player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_object_local(Vector3.UP, 0.001)
	
	var input_dir := Input.get_vector("left", "right", "up", "down")
	
	if player != null and not input_dir.length() != 0:
		player.rotation.y = lerp_angle(player.rotation.y, rotation.y , 0.1)
	elif player != null and input_dir.length() != 0:
		player.rotation.y = 0
		
	
func _on_detection_body_entered(body: Node3D) -> void:
	player = body
func _on_detection_body_exited(body: Node3D) -> void:
	player.rotation.y = 0
	player = null
