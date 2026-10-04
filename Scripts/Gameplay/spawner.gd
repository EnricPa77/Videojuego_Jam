extends Node2D

@export var Template: PackedScene

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		var unit = Template.instantiate()
		add_child(unit)
		unit.global_position = get_global_mouse_position()
