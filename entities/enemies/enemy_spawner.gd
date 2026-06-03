extends Node2D

@export var round_1_enemies: PackedScene
@export var round_2_enemies: PackedScene
@export var final_boss: PackedScene
var max_enemy_spawns := 5
@onready var timer := $Timer
@onready var spawn_point := $Marker2D
var enemies_spawned := 0
var enemies_killed := 0
var current_round := 1


func _ready() -> void:
	timer.start()
	enemies_spawned = 0
	enemies_killed = 0

func _process(delta: float) -> void:
	
	pass

func spawn_enemy() -> void:
	timer.wait_time = 5.0
	
	if current_round == 1:
		var enemy_round_1 = round_1_enemies.instantiate()
		enemy_round_1.enemy_died.connect(_on_enemy_died)
		enemy_round_1.global_position = spawn_point.global_position
		get_tree().current_scene.add_child(enemy_round_1)
		enemies_spawned += 1
	
	elif current_round == 2:
		var enemy_round_2 = round_2_enemies.instantiate()
		enemy_round_2.enemy_died.connect(_on_enemy_died)
		enemy_round_2.global_position = spawn_point.global_position
		get_tree().current_scene.add_child(enemy_round_2)
		enemies_spawned += 1
		
func _on_enemy_died() -> void:
	enemies_killed += 1
	if enemies_killed >= enemies_spawned:
		enemies_spawned = 0
		current_round = 2
	else:
		pass



func _on_timer_timeout() -> void:
	if enemies_spawned < max_enemy_spawns:
		spawn_enemy()
	elif enemies_spawned >= max_enemy_spawns:
		return
	
