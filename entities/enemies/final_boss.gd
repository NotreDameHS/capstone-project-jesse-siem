class_name Boss extends Enemy



@onready var boss_marker_1 = $Marker2D
@onready var boss_marker_2 = $Marker2D2


#func _physics_process(delta: float) -> void:
	#if player == null:
		#return
#
	#look_at(player.global_position)
	#rotation += deg_to_rad(90)
	#direction = (player.global_position - global_position).normalized()
	#var velocity := (direction * enemy_speed)
	#global_position += (velocity * delta)
	
	
func shoot_at_player() -> void:
	if player == null:
		return
	
	print("BOSS")
	# Spawning projectile at marker 1
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = spawn_point.global_position
	var direction = (player.global_position - global_position).normalized()
	projectile.direction = direction
	
	# Spawning second projectile at marker 2
	var projectile_2 = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile_2)
	projectile_2.global_position = boss_marker_2.global_position
	var direction_2 = (player.global_position - global_position).normalized()
	projectile_2.direction = direction_2
