extends Node

@onready var parent := $".."
@onready var animation = get("parameters/playback")

func _process(delta: float) -> void:
	# Run and Idle
	if parent.velocity.x != 0 or parent.velocity.z != 0:
		animation.travel("Run")
	else:
		animation.travel("Idle")

	# Jump and Fall
	if parent.velocity.y < 0 and not parent.is_on_floor():
		animation.travel("Fall")
	elif parent.velocity.y > 0 and not parent.is_on_floor():
		animation.travel("Jump")

	# Slide
	if parent.is_sliding:
		animation.travel("Dive")
