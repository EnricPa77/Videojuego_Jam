extends Control
 
@onready var play_button = $PanelContainer/MarginContainer/VBoxContainer2/Play
@onready var exit_button = $PanelContainer/MarginContainer/VBoxContainer2/Exit
 
func _ready():
	play_button.pressed.connect(_on_play_pressed)
	exit_button.pressed.connect(_on_exit_pressed)
 
func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/World.tscn")
 
func _on_exit_pressed():
	get_tree().quit()
