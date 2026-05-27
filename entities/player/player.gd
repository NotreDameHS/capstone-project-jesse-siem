extends Area2D

var normal_speed := 900.0
var max_speed := normal_speed
var velocity := Vector2(0, 0)
var steering_factor := 10.0


@export var projectile_scene: PackedScene
var mouse_global_pos: Vector2


func _ready() -> void:
	pass
	
	
func _process(delta: float) -> void:
	# Rotates ship 90 degrees to the right to make RIGHT = right
	rotation += deg_to_rad(90)
	
	# Rotates ship to point towards mouse_global_position
	var  mouse_global_pos = get_global_mouse_position()
	look_at(mouse_global_pos)
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
func _physics_process(delta: float) -> void:
	# Movement for ship
	var direction := Vector2(0, 0)
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	
	if direction.length() > 1.0:
		direction = direction.normalized()
		
	var desired_velocity := (direction * max_speed)
	var steering_vector := (desired_velocity - velocity)
	velocity += (steering_vector * steering_factor * delta)
	global_position += (velocity * delta)
	
	
func shoot() -> void:
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position
	

	
	
