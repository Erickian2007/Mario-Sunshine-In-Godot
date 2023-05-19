extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Plataforms"):
		if body.to != Vector3.ZERO:
			
			if body.get_to().x > 0:
				body.set_to(Vector3.LEFT)
			elif body.get_to().x < 0:
				body.set_to(Vector3.RIGHT)
				
			if body.get_to().y > 0:
				body.set_to(Vector3.DOWN)
			elif body.get_to().y < 0:
				body.set_to(Vector3.UP)
				
			if body.get_to().z > 0:
				body.set_to(Vector3.FORWARD)
			elif body.get_to().z < 0:
				body.set_to(Vector3.BACK)
