extends AnimationTree
class_name PlayerAnimation

@onready var player := $".."
@onready var state = player.get_node("State")
@onready var animation = get("parameters/playback")

func _process(_delta: float) -> void:
	match state.state:
		state.IDLE:
			idle()
		state.RUN:
			run()
		state.JUMP:
			jump()
		state.FALL:
			fall()
		state.WALLSLIDE:
			wall_silde()
		state.WALLJUMP:
			pass
#
#	if (player.is_on_floor()):
#		if (player.velocity):
#			run()
#		else:
#			idle()
#	elif (!player.is_on_floor() && !player.is_on_wall()):
#		if (player.velocity.y > 0):
#			jump()
#		else:
#			fall()
#	elif (!player.is_on_floor() && player.is_on_wall()):
#		wall_silde()
func idle() -> void:
	animation.travel("Idle")
func run() -> void:
	animation.travel("Run")
func fall() -> void:
	animation.travel("Fall")
func jump() -> void:
	animation.travel("Jump")
func wall_silde() -> void:
	animation.travel("WallSlide")
