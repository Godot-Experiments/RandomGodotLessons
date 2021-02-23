extends Sprite


func _physics_process(delta):
	var gmp := get_global_mouse_position()
#	rotation = 
	look_at(gmp)
#	rotation += PI
	position = lerp(position, position + gmp - $Position2D2.global_position, .1)
