extends Node
class_name States

@onready var player: CharacterBody3D = get_parent()
@onready var animation: AnimationTree = player.get_node("AnimationTree")

enum {IDLE, RUN, JUMP, FALL, WALLSLIDE, WALLJUMP}
var state = IDLE

