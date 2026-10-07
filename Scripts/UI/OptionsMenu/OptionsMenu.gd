extends Panel

signal back_pressed

@onready var back_button = $Back

func _ready() -> void:
	back_button.pressed.connect(func(): back_pressed.emit())
