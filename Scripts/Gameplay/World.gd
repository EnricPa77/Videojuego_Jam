extends Node2D

class_name World

@export var units_config: Array[UnitConfig]



func _input(event: InputEvent) -> void:
	pass

func get_units_config() -> Array[UnitConfig]:
	return units_config
