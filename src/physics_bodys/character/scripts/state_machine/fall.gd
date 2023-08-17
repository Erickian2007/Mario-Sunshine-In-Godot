extends Node

@onready var player = $"../.."
@onready var parent = $".."
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!player.is_on_wall() && !player.is_on_floor() && player.velocity.y > 0):
		parent.state = parent.FALL
