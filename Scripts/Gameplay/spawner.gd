extends Node2D

@export var units: Array[UnitConfig]

var unit: UnitTemplate

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		var unit = units[0].UnitScene.instantiate()
		unit.unitBuilder(units[0].Speed)
		add_child(unit)
		unit.global_position = get_global_mouse_position()
