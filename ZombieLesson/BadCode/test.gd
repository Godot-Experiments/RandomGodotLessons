extends Sprite


func _physics_process(delta):
	var gmp := get_global_mouse_position()
	look_at(gmp)
	position = lerp(position, position + gmp - $Position2D2.global_position, .1)
