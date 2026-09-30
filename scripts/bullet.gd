extends Area2D

const speed := 100

var direction : Vector2

func set_target_position(new_target_pos: Vector2):
	look_at(new_target_pos)
	direction = (new_target_pos - global_position).normalized()

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.take_damage(50.0)
		queue_free()

func _on_timer_timeout():
	queue_free()
