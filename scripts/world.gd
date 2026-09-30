class_name World
extends Node2D

const TOWER_SIZE := 32            # tamaño de la torre en píxeles (32x32)
const HALF := Vector2(16, 16)     # TOWER_SIZE / 2

@export var total_enemies := 15
@export var enemy_scene : PackedScene
@export var tower_cost := 200
@export var enemy_reward := 10

var spawned_enemies := 0

var build_mode := false
var overlaps := 0                 # áreas de construcción que toca el BuildChecker
var tower_build : PackedScene
var coins := 400
var tower_positions : Array[Vector2] = []   # posiciones de las torres ya colocadas

func _ready():
	update_coins()

	# Reproducir la animación del castillo (si es un AnimatedSprite2D)
	var castle = get_node_or_null("Castle")
	if castle is AnimatedSprite2D:
		castle.play()

func _process(_delta):
	var mouse := get_global_mouse_position()

	# El checker sigue al ratón (su origen es la esquina superior izquierda de la torre)
	$BuildChecker.global_position = mouse - HALF

	# La torre "fantasma" sigue al ratón y cambia de color según si se puede construir
	if build_mode:
		$BuildTower.global_position = mouse
		if can_place():
			$BuildTower/Sprite2D.modulate = Color(0.6, 1.0, 0.6, 0.8)
		else:
			$BuildTower/Sprite2D.modulate = Color(1.0, 0.4, 0.4, 0.8)

func _input(event):
	if not build_mode:
		return

	if event is InputEventMouseButton and event.pressed:
		# Clic izquierdo = colocar la torre (solo si el sitio es válido)
		if event.button_index == MOUSE_BUTTON_LEFT:
			if can_place():
				place_tower()
				toggle_build_mode(false, null, null)
		# Clic derecho = cancelar
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			toggle_build_mode(false, null, null)

	# Esc = cancelar
	elif event.is_action_pressed("ui_cancel"):
		toggle_build_mode(false, null, null)

func _on_enemy_spawn_timeout():
	if spawned_enemies < total_enemies:
		if enemy_scene:
			var enemy = enemy_scene.instantiate()
			$Path2D.add_child(enemy)
			spawned_enemies += 1
	else:
		$EnemySpawn.stop()

func toggle_build_mode(active : bool, sprite : Texture, tower_to_build : PackedScene):
	build_mode = active
	$BuildTower.visible = active
	if active:
		$BuildTower/Sprite2D.texture = sprite
		$BuildTower.global_position = get_global_mouse_position()
		tower_build = tower_to_build
	else:
		tower_build = null

# ¿Hay ya una torre solapando esta posición?
func is_spot_free(pos : Vector2) -> bool:
	for p in tower_positions:
		if abs(p.x - pos.x) < TOWER_SIZE and abs(p.y - pos.y) < TOWER_SIZE:
			return false
	return true

func can_place() -> bool:
	return overlaps > 0 and coins >= tower_cost and is_spot_free(get_global_mouse_position())

func place_tower():
	var pos := get_global_mouse_position()
	var tower = tower_build.instantiate()
	add_child(tower)
	tower.global_position = pos      # se queda exactamente donde la has soltado
	tower_positions.append(pos)

	coins -= tower_cost
	update_coins()

func _on_build_checker_area_entered(_area):
	overlaps += 1

func _on_build_checker_area_exited(_area):
	overlaps = max(overlaps - 1, 0)

func add_coins(amount : int):
	coins += amount
	update_coins()

func update_coins():
	$CanvasLayer/HUD.update_coins(coins)
