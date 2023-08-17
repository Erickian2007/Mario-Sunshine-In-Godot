extends Node

@onready var player = $"../.."
@onready var parent = $".."
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var input_dir: Vector3 = Vector3.ZERO
	input_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_dir.z = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if (!player.is_on_floor() && player.is_on_wall() && player.velocity.y < 0 && input_dir):
		print("wallslide")
		parent.state = parent.WALLSLIDE
		player.velocity.y = lerp(player.velocity.y, 0.0, 1)
