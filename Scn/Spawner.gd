extends Node2D

var spawn_points
var player
export (PackedScene) var zombie = preload("res://Scn/Zombie.tscn")

func _ready():
	var window_size = get_viewport_rect().size

	spawn_points = [
		Vector2(window_size.x / 2, 0),
		Vector2(window_size.x / 2, window_size.y),
		Vector2(0, window_size.y / 2),
		Vector2(window_size.x, window_size.y / 2)
	]
	player = get_node("../Player")
	spawn_zomb()
	$SpawnTimer.wait_time = .5
	$SpawnTimer.start()


func spawn_zomb():
	var zomb: Zombie = zombie.instance()
	add_child(zomb) # add child underneath "EnemySpawner"
	zomb.position = spawn_points[randi() % 4]
	zomb.target = player

func _on_Timer_timeout():
	spawn_zomb()
