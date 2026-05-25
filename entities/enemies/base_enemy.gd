extends Area2D
# 
@export var max_health := 100.0
@export var health = max_health

@onready var health_bar := $UI/HealthBar

var player = null
var direction := Vector2(0, 0)
var enemy_speed := 50.0


func _ready() -> void:
	health = max_health
	health_bar.max_value = max_health
	health_bar.value = health
	player = get_tree().get_nodes_in_group("Player")

func _proccess(delta: float) -> void:
	if player == null:
		return
	
	look_at(player.global_position)
	direction = (player.global_position - global_position).normalized()
	var velocity = (direction * enemy_speed)
	global_position += (velocity * delta)





func _take_damage(amount: float) -> void:
	if amount >= health:
		health = 0.0
		health_bar.value = health
		queue_free()
	else:
		health -= amount
		health_bar.value = health
