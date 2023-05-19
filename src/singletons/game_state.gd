extends Node

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and Input.get_mouse_mode() != 2:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel") and Input.get_mouse_mode() == 2:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event.is_action_pressed("ui_page_down"):
		get_tree().reload_current_scene()
	elif Input.is_action_pressed("select") and Input.is_action_pressed("start"):
		get_tree().reload_current_scene()
		
