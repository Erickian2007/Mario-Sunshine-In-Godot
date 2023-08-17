extends Node

@onready var player = $"../.."
@onready var parent = $".."
func _physics_process(delta: float) -> void:
	if (Input.is_action_just_pressed("jump") && player.is_on_floor()):
		player.velocity.y = player.jump_force
		parent.state = parent.JUMP
