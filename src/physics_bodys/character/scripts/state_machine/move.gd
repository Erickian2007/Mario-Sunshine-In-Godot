extends Node

@onready var player = $"../.."
@onready var parent = $".."
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var input_dir: Vector3 = Vector3.ZERO
	input_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_dir.z = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_dir = input_dir.rotated(Vector3.UP, player.spring_arm.rotation.y).normalized()
	
	if (input_dir):
		player.velocity.x = lerp(player.velocity.x, input_dir.x * player.speed, player.acel_speed)
		player.velocity.z = lerp(player.velocity.z, input_dir.z * player.speed, player.acel_speed)
		
		if (!Input.is_action_pressed("jump")):
			parent.state = parent.RUN
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, player.acel_speed)
		player.velocity.z = lerp(player.velocity.z, 0.0, player.acel_speed)
		
		parent.state = parent.IDLE
