extends Control

@export var world_ref : World
@export var towers : Array[PackedScene] = []
@export var textures : Array[Texture] = []

func update_coins(coins : int):
	$Label.text = "GOLD:" + str(coins)

func start_build_mode(tower_ref : PackedScene, texture : Texture):
	world_ref.toggle_build_mode(true, texture, tower_ref)

func _on_button_button_down():
	# Solo se comprueba que haya dinero; el cobro se hace al colocar la torre
	if world_ref.build_mode:
		return
	if world_ref.coins >= world_ref.tower_cost:
		start_build_mode(towers[0], textures[0])
