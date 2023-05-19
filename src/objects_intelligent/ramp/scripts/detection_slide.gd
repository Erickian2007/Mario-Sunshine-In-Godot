extends Area3D
class_name DetectionSlide

var get_last_slop: Vector3
var slide:         Vector3 

var can_slide: bool = false

const slide_multiplier: int = 20

const force:  int = 10
const weight: float = 1.0

func _physics_process(delta: float) -> void:
	if can_slide:
		# getting last motion of the slope
		if Global.player.get_last_motion().length() != 0: get_last_slop = Global.player.get_last_motion()
		
		# checking if can slide
		slide = Vector3(
			(Global.player.velocity.x + get_last_slop.x) * slide_multiplier,
			0,
			(Global.player.velocity.z + get_last_slop.z) * slide_multiplier
			).normalized()
		
		Global.player.velocity    = lerp(Global.player.velocity, slide * force, weight)
		Global.player.velocity.y -= 20
		
		Global.player.is_sliding = true
	else:
		Global.player.is_sliding = false
		
func _on_body_entered(body: CharacterBody3D) -> void:
	if body.velocity.y < -10:
		can_slide = true
	
	
func _on_body_exited(body: CharacterBody3D) -> void:
	can_slide        = false
