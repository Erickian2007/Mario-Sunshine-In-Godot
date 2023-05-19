extends CollisionShape3D

@onready var model = $"../Model"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation.y = model.rotation.y
