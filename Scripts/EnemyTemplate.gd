extends CharacterBody2D

class_name EnemyTemplate

@export var Speed: float = 20.0

var target_position: Vector2
var moving := false
var isSelected := false

func move_to(target: Vector2) -> void:
	target_position = target
	moving = true

func _physics_process(delta: float) -> void:
	
	# Moverse hacia el punto
	if moving:
		var direction = global_position.direction_to(target_position)
		velocity = direction * Speed
		move_and_slide()

		# Comprobar si hemos llegado
		if global_position.distance_to(target_position) < 5.0:
			global_position = target_position
			velocity = Vector2.ZERO
			moving = false
			
