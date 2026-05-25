extends Area2D
# 
@export var max_health := 100.0
@export var health = max_health
@onready var health_bar := $UI/HealthBar
@export var projectile_scene: PackedScene
@onready var timer = $Timer


var player = null # player node
var direction := Vector2(0, 0)
var enemy_speed := 50.0  # enemy speed


func _ready() -> void:
	health = max_health
	health_bar.max_value = max_health
	health_bar.value = health
	player = get_tree().current_scene.get_nodes_in_group("Player")
	timer.wait_time = 1.0
	timer.start()

func _physics_proccess(delta: float) -> void:
	if player == null:
		return
		
	# Finds player and moves towards player
	look_at(player.global_position)
	direction = (player.global_position - global_position).normalized()
	var velocity = (direction * enemy_speed)
	global_position += (transform.x * velocity * delta)


func shoot_at_player() -> void:
	if player == null:
		return
	
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position


func _take_damage(amount: float) -> void:
	if amount >= health:
		health = 0.0
		health_bar.value = health
		queue_free()
	else:
		health -= amount
		health_bar.value = health


func _on_timer_timeout() -> void:
	shoot_at_player()
