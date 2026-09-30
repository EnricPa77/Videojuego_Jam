extends StaticBody2D

@export var bullet_scene : PackedScene

var current_target = null
var total_targets := []
var can_shoot : bool = true

func _process(_delta):
	# Quitar enemigos que ya han sido eliminados
	total_targets = total_targets.filter(func(t): return is_instance_valid(t))

	# Elegir el enemigo que va más avanzado en el camino
	current_target = null
	for t in total_targets:
		if current_target == null or t.get_parent().progress_ratio > current_target.get_parent().progress_ratio:
			current_target = t

	if current_target != null and can_shoot:
		can_shoot = false
		shoot()
		$TimerCD.start()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		if !total_targets.has(body):
			total_targets.append(body)

func _on_area_2d_body_exited(body):
	if body.is_in_group("Enemy"):
		total_targets.erase(body)

func shoot():
	if bullet_scene == null or current_target == null:
		return
	var bullet = bullet_scene.instantiate()
	add_child(bullet)
	bullet.global_position = $Marker2D.global_position
	bullet.set_target_position(current_target.global_position)

func _on_timer_cd_timeout():
	can_shoot = true
