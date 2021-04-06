extends Damageable
class_name Moveable

export var speed := 200
export var walk_speed := 75
export var TURN := 20 # turning speed
export var player_controlled := false

var target # for AI
