class_name Bullet
extends RigidBody2D

var rot: float = 0
export (PackedScene) var spray_s := preload("res://Scn/Spray.tscn")

# this happens when our bullet hits another kinematic or rigid body
func _on_Bullet_body_entered(body) -> void:
	# if we hit an enemy
	if body.is_in_group("Enemies"):
		if body.has_method("dmg"):
			body.dmg(1)
	spawn_spray()
	# despawn if we hit anything
	queue_free()

# sets up spray
func spawn_spray() -> void:
	var spray = spray_s.instance()
	spray.global_rotation = rot - PI
	spray.emitting = true
	spray.position = position
	get_parent().add_child(spray)

# I made this so we could set the spray rotation easily
func set_rot(angle: float) -> void:
	# sets rotation
	rotation = angle
	rot = angle

# Happens when the timer runs out
func _on_Timer_timeout() -> void:
	# When the timer runs out, we want the bullet to despawn
	queue_free()
