extends Area2D

var normal_speed := 900.0
var max_speed := normal_speed
var velocity := Vector2(0, 0)
var steering_factor := 10.0

@export var projectile_scene: PackedScene



func _ready() -> void:
	pass
	
	
func _process(delta: float) -> void:
	var direction := Vector2(0, 0)
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	

	
	if direction.length() > 1.0:
		direction = direction.normalized()
		
	var desired_velocity := (direction * max_speed)
	var steering_vector := (desired_velocity - velocity)
	velocity += (steering_vector * steering_factor * delta)
	global_position += (velocity * delta)
	
	if velocity.length() > 0.0:
		get_node("Sprite2D").rotation = velocity.angle()
	
	
	
	
func shoot() -> void:
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position
	

	
	
