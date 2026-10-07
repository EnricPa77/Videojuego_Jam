extends Control
 
@onready var play_button = $MainButtons/MarginContainer/VBoxContainer2/Play
@onready var exit_button = $MainButtons/MarginContainer/VBoxContainer2/Exit
@onready var options_button = $MainButtons/MarginContainer/VBoxContainer2/Options
@onready var main_buttons = $MainButtons
@onready var options_menu = $OptionsMenu
@onready var back_options_button = $OptionsMenu/Back
@onready var tittle = $Tittle

func _ready():
	main_buttons.visible = true
	options_menu.visible = false
	tittle.visible = true
	play_button.pressed.connect(_on_play_pressed)
	exit_button.pressed.connect(_on_exit_pressed)
	options_button.pressed.connect(_on_options_pressed)
	back_options_button.pressed.connect(_on_back_options_pressed)

func _on_options_pressed():
	main_buttons.visible = false
	options_menu.visible = true
	tittle.visible = false

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
 
func _on_back_options_pressed():
	main_buttons.visible = true
	options_menu.visible = false
	tittle.visible = true

func _on_exit_pressed():
	get_tree().quit()
