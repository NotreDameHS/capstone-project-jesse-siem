class_name Boss extends Enemy



@onready var boss_marker_1 = $Marker2D
@onready var boss_marker_2 = $Marker2D2
@onready var boss_marker_3 = $Marker2D3
@onready var boss_marker_4 = $Marker2D4
@onready var boss_marker_5 = $Marker2D5
@export var boss_projectile_scene: PackedScene



	
	
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
	
	var projectile_5 = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile_5)
	projectile_5.global_position = boss_marker_5.global_position
	var direction_5 = (player.global_position - global_position).normalized()
	projectile_5.direction = direction_5
	
	
	
	var projectile_3 = boss_projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile_3)
	projectile_3.global_position = boss_marker_3.global_position
	var direction_3 = (player.global_position - global_position).normalized()
	projectile_3.direction = direction_3
	
	var projectile_4 = boss_projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile_4)
	projectile_4.global_position = boss_marker_4.global_position
	var direction_4 = (player.global_position - global_position).normalized()
	projectile_4.direction = direction_4
	
	
	
