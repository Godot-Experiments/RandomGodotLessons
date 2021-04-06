class_name Exhibit
extends Node2D

#export var text := ""
export (NodePath) var msg
export (NodePath) var txt
export (NodePath) var hidden
onready var Msg = get_node(msg)
onready var Txt = get_node(txt)
onready var Hidden = get_node(hidden)
onready var Anim = $Anim
onready var Center := $All/Center



func set_txt(text: String) -> void:
	Txt.text = text

func add_hidden(node) -> void:
	Hidden.add_child(node)

func add(node: Control) -> void:
	Center.add_child(node)
	node.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	node.connect("gui_input", self, "_on_Sprite_gui_input")

func _on_Sprite_gui_input(event: InputEvent) -> void:
	if event.is_action("click"):
		Msg.show()
		Hidden.show()
		Anim.play("Show")

