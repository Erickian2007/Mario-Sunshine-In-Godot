extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Plataforms"):
		print(body.name)
		if body.get_current_state():
			
			if body.get_current_state() == body.LEFT:
				body.set_current_state(body.UP)
				body.play_90_degrees()
			elif body.get_current_state() == body.RIGHT:
				body.set_current_state(body.DOWN)
				body.play_90_degrees()
			elif body.get_current_state() == body.DOWN:
				body.set_current_state(body.LEFT)
				body.play_90_degrees()
			elif body.get_current_state() == body.UP:
				body.set_current_state(body.RIGHT)
				body.play_90_degrees()
