extends Area2D
# 
@export var max_health := 100.0
@export var health = max_health

@onready var health_bar := $UI/HealthBar

func _ready() -> void:
	health = max_health
	health_bar.max_value = max_health
	health_bar.value = health

func _take_damage(amount: float) -> void:
	if amount >= health:
		health = 0.0
		health_bar.value = health
		queue_free()
	else:
		health -= amount
		health_bar.value = health
