extends Node2D

class_name MouseSelection

@onready var selection_rect: ColorRect = $SelectionRect

var mouse_dragging: bool = false
var drag_start_position: Vector2
var drag_final_position: Vector2
var selected_units: Array[UnitTemplate]

func _input(event: InputEvent) -> void:
		

	if event.is_action_pressed("right_click"):
		var target: Vector2 = event.position

		for unit in selected_units:
			unit.move_to(target)
			
	elif mouse_dragging and event is InputEventMouseMotion:
		var rect := Rect2(drag_start_position,event.position - drag_start_position).abs()
		selection_rect.position = rect.position
		selection_rect.size = rect.size

#Dibuja el rectángulo que sirve para seleccionar unidades pero no las selecciona
func draw_rectangle(event: InputEvent) -> void:
	mouse_dragging = true
	drag_start_position = event.position
	selection_rect.show()
	selection_rect.position = drag_start_position
	selection_rect.size = Vector2.ZERO
	
#Comprueba la distancia desde el inicio del rectángulo y hasta el final y selecciona unidades
func stop_draw_rectangle(event: InputEvent) -> void:
	mouse_dragging = false
	selection_rect.hide()
	drag_final_position = event.position
	#Si mueves más de 10 pixeles cuenta como que has mantenido el click.
	if (drag_start_position - drag_final_position).length() > 10:
		var rect := Rect2(drag_start_position,event.position - drag_start_position).abs()
		#Selecciona las unidades de dentro del rectángulo
		update_selection(rect)
	#De lo contrario, cuenta como click.
	else:
		select_unit(event)

#Selecciona las unidades a partir del rectángulo que se le pasa, las que no están dentro se desseleccionan
func update_selection(rect: Rect2) -> void:
	selected_units.clear()
	
	var all_units = get_tree().get_nodes_in_group("unit")

	for unit in all_units:
		if rect.has_point(unit.global_position):
			unit.isSelected = true
			selected_units.append(unit)
		else:
			unit.isSelected = false
			
func select_unit(event: InputEvent):
	var mouse_position: Vector2 = event.position

	var query := PhysicsPointQueryParameters2D.new()
	query.position = mouse_position
	query.collide_with_areas = true
	query.collide_with_bodies = true

	var results: Array[Dictionary] = get_world_2d().direct_space_state.intersect_point(query)
	
	var all_units: Array[UnitTemplate] = []

	for node in get_tree().get_nodes_in_group("unit"):
		if node is UnitTemplate:
			all_units.append(node)
			
	for units in all_units:
		units.isSelected = false
	
	selected_units.clear()
	
	for result in results:
		var collider = result.collider
		print(collider)
		if collider is UnitTemplate:
			
			var unit: UnitTemplate = collider
			unit.select()
			selected_units.append(unit)
			return
			

	

	
	
func get_units() -> Array[UnitTemplate]:
	return selected_units 
