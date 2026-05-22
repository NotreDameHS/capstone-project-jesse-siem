class_name Projectile extends Area2D

@export var damage := 50
@export var max_distance := 1000
@export var speed := 200
var _distance_traveled := 0 

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta
	
	_distance_traveled += speed * delta
	
	if _distance_traveled > max_distance:
		_explode()
	
func _explode() -> void:
	queue_free()	
