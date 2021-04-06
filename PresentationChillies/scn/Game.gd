class_name Game
extends Node2D

onready var player := $Player
onready var ground := $Ground
var limit_left := -1600
var limit_right := 1600

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# Goes out of bounds, need to reposition floor
	if player.position.x < limit_left:
		ground.position.x -= 1600
		adjust_limits(false)
	elif player.position.x > limit_right:
		ground.position.x += 1600
		adjust_limits(true)

func adjust_limits(right : bool) -> void:
	if right:
		limit_left += 1600
		limit_right += 1600
	else:
		limit_left -= 1600
		limit_right -= 1600

