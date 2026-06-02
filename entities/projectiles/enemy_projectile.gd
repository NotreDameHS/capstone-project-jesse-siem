class_name Enemy_Projectile extends Area2D

@export var damage := 50
@export var max_distance := 1000
@export var speed := 200
var _distance_traveled := 0 
var direction := Vector2.ZERO

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta
	rotation = direction.angle()
	
	_distance_traveled += speed * delta
	
	if _distance_traveled > max_distance:
		_explode()
	
func _explode() -> void:
	queue_free()	



func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		area._take_damage(25.0)
		_explode()
	else:
		pass
	
	
