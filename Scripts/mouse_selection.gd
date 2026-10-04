extends Node

@onready var selection_rect: ColorRect = self.get_child(0)

var mouse_dragging: bool = false
var drag_start_position: Vector2
var drag_final_position: Vector2
var selected_units: Array[CharacterBody2D]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		mouse_dragging = true
		drag_start_position = event.position
		selection_rect.show()
		selection_rect.position = drag_start_position
		selection_rect.size = Vector2.ZERO

	elif event.is_action_released("click"):
		mouse_dragging = false
		selection_rect.hide()
		drag_final_position = event.position
		#Esto basicament es si has movido el raton desde que haces click hasta que lo dejas más de 10 px.
		if (drag_start_position - drag_final_position).length() > 10:
			var rect := Rect2(drag_start_position,event.position - drag_start_position).abs()
			_update_selection(rect)
		else:
			pass
			#_select_unit(event)

	elif event.is_action_pressed("right_click"):
		var target: Vector2 = event.position

		for unit in selected_units:
			unit.move_to(target)
			
	elif mouse_dragging and event is InputEventMouseMotion:
		var rect := Rect2(drag_start_position,event.position - drag_start_position).abs()
		selection_rect.position = rect.position
		selection_rect.size = rect.size


func _update_selection(rect: Rect2) -> void:
	selected_units.clear()

	var all_units = get_tree().get_nodes_in_group("unit")

	for unit in all_units:
		if rect.has_point(unit.global_position):
			unit.isSelected = true
			selected_units.append(unit)
		else:
			unit.isSelected = false
			
func _select_unit(event: InputEvent):
	selected_units.clear()
	
	var all_units = get_tree().get_nodes_in_group("unit")
