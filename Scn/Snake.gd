extends Node2D


func _ready():
	var prev: Sprite
	for child in get_children():
		
		if child is Chain:#Sprite and child.name != "icon":
			child.target = prev
		prev = child
	set_physics_process(false)


func _physics_process(delta):
	for child in get_children():
		if child is Chain:#Sprite and child.name != "icon":
			child.look_at(child.target.global_position)
			child.global_position = lerp(child.global_position, child.global_position+ child.target.global_position - child.front.global_position, .1)
