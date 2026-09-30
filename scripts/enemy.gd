extends CharacterBody2D

const speed := 30
var health := 100.0
var dead := false

@onready var enemy_path : PathFollow2D = get_parent()

func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	enemy_path.progress = enemy_path.progress + (speed * delta)
	
	if enemy_path.progress_ratio >= 0.99:
		get_parent().queue_free()

func take_damage(damage : float = 1.0):
	if dead:
		return
	health -= damage
	if health <= 0:
		dead = true
		# Dar la recompensa al mundo (solo si muere por daño, no al llegar al final)
		var world = get_tree().current_scene
		if world is World:
			world.add_coins(world.enemy_reward)
		get_parent().queue_free()
