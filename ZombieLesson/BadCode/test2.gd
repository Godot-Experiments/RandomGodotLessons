extends Sprite
class_name Chain

onready var target# = get_parent().get_node("icon/Position2D")
export (NodePath) var target_path
onready var front = $Position2D2

func _ready():
	target = get_node(target_path)

#func _physics_process(delta):
#	look_at(target.global_position)
#	global_position += target.global_position - $Position2D2.global_position
