extends Node2D

onready var Question := $CanvasLayer/Question

func _physics_process(delta: float) -> void:
	# Zombies DOTS, need to put enemies in array for true DOTS
	for enemy in get_tree().get_nodes_in_group(Global.ENEMIES):
		enemy.Value.set_rotation(-enemy.rotation)

		if is_instance_valid(enemy.target):
			enemy.rotation += clamp(enemy.to_local(enemy.target.global_position).angle() * 10, -enemy.TURN, enemy.TURN) * delta
			enemy.position += Vector2.RIGHT.rotated(enemy.rotation) * delta * enemy.speed

