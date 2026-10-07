extends Node2D

@onready var mouseSelection: MouseSelection = $MouseSelection
@onready var world: World = get_parent()

var units_config: Array[UnitConfig]
var units: Array[UnitTemplate]


func _input(event: InputEvent) -> void:
	#Si clica empieza a dibujar el rectangulo que selecciona unidades
	if event.is_action_pressed("click"):
		mouseSelection.draw_rectangle(event)

	#Si deja de clicar calcula la distancia desde el inicio hasta el final
	if event.is_action_released("click"):
		mouseSelection.stop_draw_rectangle(event)

	#Si haces click derecho, mueve las unidades seleccionadas a la posición del mundo
	if event.is_action_pressed("right_click"):
		move_units(mouseSelection)
		
	if event.is_action_pressed("space"):
		spawn_unit()
		





func move_units(mouseSelection: MouseSelection):
	var selected_units: Array[UnitTemplate]
	mouseSelection.get_units()
	var target: Vector2 = get_global_mouse_position()
	for unit in selected_units:
		if unit.isSelected:
			unit.move_to(target)

func spawn_unit():
	units_config = world.get_units_config()
	var unit = units_config[0].UnitScene.instantiate()
	unit.unit_setup(units_config[0].Speed)
	world.add_child(unit)
	units.append(unit)
	unit.global_position = world.get_global_mouse_position()
