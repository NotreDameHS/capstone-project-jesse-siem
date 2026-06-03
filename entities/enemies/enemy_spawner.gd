extends Node2D

@export var round_1_enemies: PackedScene
@export var round_2_enemies: PackedScene
@export var final_boss: PackedScene
var max_enemy_spawns := 5
@onready var timer := $Timer
@onready var spawn_point := $Marker2D
var enemies_spawned := 0
#var spawn_wait_time := 2.0


func _ready() -> void:
	timer.start()
	

func spawn_enemy() -> void:
	var enemy_round_1 = round_1_enemies.instantiate()
	enemy_round_1.global_position = spawn_point.global_position
	get_tree().current_scene.add_child(enemy_round_1)
	enemies_spawned += 1






func _on_timer_timeout() -> void:
	if enemies_spawned < max_enemy_spawns:
		spawn_enemy()
	elif enemies_spawned >= max_enemy_spawns:
		return
	
