extends Node2D

@export var round_1_enemies: PackedScene
@export var round_2_enemies: PackedScene
@export var final_boss: PackedScene
@export var round_1_enemy_spawns := 1
@export var round_2_enemy_spawns := 8
@onready var timer := $Timer
@onready var enemy_spawn_point := $Marker2D
var enemies_to_be_spawned := 0




var enemies_spawned := 0
var current_round := 1
var enemies_alive := 0 

func _ready() -> void:
	timer.wait_time = 2.0
	enemies_spawned = 0
	enemies_alive = 0
	enemies_to_be_spawned = round_1_enemy_spawns
	current_round = 1
	timer.start()
	

		
		
func spawn_enemy() -> void:
	
	if current_round == 1:
		print("Beginning Round 1!")
		var enemy_round_1 = round_1_enemies.instantiate()
		enemy_round_1.enemy_died.connect(_on_enemy_died)
		enemy_round_1.global_position = enemy_spawn_point.global_position
		get_tree().current_scene.add_child(enemy_round_1)
		enemies_spawned += 1
		enemies_alive += 1
	
	elif current_round == 2:
		print("Beginning Round 2!")
		var enemy_round_2 = round_2_enemies.instantiate()
		enemy_round_2.enemy_died.connect(_on_enemy_died)
		enemy_round_2.global_position = enemy_spawn_point.global_position
		get_tree().current_scene.add_child(enemy_round_2)
		enemies_spawned += 1
		enemies_alive += 1
		
	elif current_round == 3:
		var final_boss_scene = final_boss.instantiate()
		final_boss_scene.enemy_died.connect(_on_enemy_died)
		final_boss_scene.global_position = enemy_spawn_point.global_position
		get_tree().current_scene.add_child(final_boss_scene)
		timer.stop()
		enemies_spawned += 1
		enemies_alive += 1
		
		
func _on_enemy_died() -> void:
	enemies_alive -= 1
	if enemies_alive == 0 and enemies_spawned == enemies_to_be_spawned and current_round == 1:
		enemies_spawned = 0
		enemies_alive = 0
		current_round = 2
		enemies_to_be_spawned = round_2_enemy_spawns
		print("Succesfully changed to round 2 after 5 kills")
	
	elif enemies_alive == 0 and enemies_spawned == enemies_to_be_spawned and current_round == 2:
		enemies_spawned = 0
		enemies_alive = 0
		current_round = 3
		enemies_to_be_spawned = 1
	
	elif enemies_alive == 0 and enemies_spawned == enemies_to_be_spawned and current_round == 3:
		print("END GAME!")
	
	else:
		pass



func _on_timer_timeout() -> void:
	if enemies_spawned < enemies_to_be_spawned:
		spawn_enemy()
	elif enemies_spawned >= enemies_to_be_spawned:
		return
	
