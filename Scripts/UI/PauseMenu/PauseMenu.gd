extends CanvasLayer

@onready var panel: Panel = $Panel
@onready var options_menu = $OptionsMenu
@onready var continue_button: Button = $Panel/VBoxContainer/Continue
@onready var options_button: Button = $Panel/VBoxContainer/Options
@onready var exit_to_menu_button: Button = $Panel/VBoxContainer/ExitToMenu
@onready var exit_button: Button = $Panel/VBoxContainer/Exit

func _ready() -> void:
	visible = false
	options_menu.visible = false
	continue_button.pressed.connect(_on_continue_pressed)
	options_button.pressed.connect(_on_options_pressed)
	exit_to_menu_button.pressed.connect(_on_exit_to_menu_pressed)
	exit_button.pressed.connect(_on_exit_pressed)
	options_menu.back_pressed.connect(_on_back_options_pressed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		if options_menu.visible:
			_on_back_options_pressed()
		else:
			toggle_pause()

func toggle_pause() -> void:
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused

func _on_continue_pressed() -> void:
	toggle_pause()

func _on_options_pressed() -> void:
	panel.visible = false
	options_menu.visible = true

func _on_back_options_pressed() -> void:
	options_menu.visible = false
	panel.visible = true

func _on_exit_to_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
