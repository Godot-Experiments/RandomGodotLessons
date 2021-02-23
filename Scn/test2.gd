extends Sprite

onready var target = get_parent().get_node("Position2D")

func _physics_process(delta):
	look_at(target.global_position)
	global_position = lerp(global_position, global_position + target.global_position - $Position2D2.global_position, .15)
