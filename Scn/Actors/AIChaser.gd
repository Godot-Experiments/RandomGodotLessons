extends Moveable
class_name AIChaser

onready var Value := $Value

func _ready() -> void:
	add_to_group(Global.ENEMIES)
	Value.text = Qdb.qa.keys()[randi() % Qdb.qa.size()]

# Damage the zombie by amt
func dmg(amt: int) -> void:
	hp -= amt
	if hp <= 0:
		queue_free()


