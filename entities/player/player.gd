class_name Player extends Area2D


@export var max_speed := 10000.0
var normal_speed := max_speed
var velocity := Vector2(0, 0)
var steering_factor := 10.0
var mouse_global_pos: Vector2
var shooter_1_state: bool = true
var shooter_2_state: bool = false
var player_max_health := 100.0
var player_health := 100
var kill_count: int = 0
var is_invincible = false

@export var projectile_scene: PackedScene
@onready var spawn_point = $Marker2D
@onready var spawn_point_2 = $Marker2D2
@onready var health_bar = $UI/HealthBar
@onready var ui_node = $UI
@onready var invincible_timer = $InvincibilityTimer

func _ready() -> void:
	kill_count = 0
	health_bar.max_value = player_max_health
	health_bar.value = player_health
	_set_health(player_health)
	
func _process(delta: float) -> void:
	# Rotates ship 90 degrees to the right to make RIGHT = right
	#rotation += deg_to_rad(90)
	
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
	ui_node.rotation = -global_rotation
	
func shoot() -> void:
	
	var projectile = projectile_scene.instantiate()
	projectile.global_position = spawn_point.global_position
	projectile.global_rotation = global_rotation
	
	
	var projectile_2 = projectile_scene.instantiate()
	projectile_2.global_position = spawn_point_2.global_position
	projectile_2.global_rotation = global_rotation
	
	
	var dir = Vector2.RIGHT.rotated(global_rotation)
	projectile.direction = dir
	projectile.rotation = dir.angle()
	
	var dir2 = Vector2.RIGHT.rotated(global_rotation)
	projectile_2.direction = dir2
	projectile_2.rotation = dir2.angle()
	
	# Alternate shooting for base shooting level
	if shooter_1_state == true and shooter_2_state == false:
		get_tree().current_scene.add_child(projectile)
		shooter_1_state = false
		shooter_2_state = true
	
	elif shooter_2_state == true and shooter_1_state == false:
		get_tree().current_scene.add_child(projectile_2)
		shooter_2_state = false
		shooter_1_state = true
		
	
func _take_damage(amount: float) -> void:
	if (player_health - amount) <= 0.0:
		player_health = 0.0
		queue_free()
		GameManager.show_end_screen("Game Over")
		
	if is_invincible:
		return
			
	else:
		player_health -= amount
		health_bar.value = player_health
		print(player_health)
		spawn_poof()
	
	
func kill_amount(kill_count: int) -> void:
	pass

func _set_health(new_health: int) -> void:
	player_health = new_health
	# Find the bar and update its 'value' property
	get_node("UI/HealthBar").value = player_health







func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("health"):
		_set_health(player_health + 10.0)
		if player_health >= player_max_health:
			player_health = player_max_health
		print(player_health)
		
	elif area.is_in_group("Shield"):
		is_invincible = true
		print("Player is invincible for 10 seconds!")
		invincible_timer.start()
		
	
	elif area.is_in_group("Weapon"):
		
		pass	
		


func _on_invincibility_timer_timeout() -> void:
	is_invincible = false
	print("Invincibility powerup is over!")
	

func spawn_poof():
	# Creating newCPUParticles2D node
	var particles = CPUParticles2D.new()
	get_tree().current_scene.add_child(particles)
	particles.global_position = global_position
	
	
# Create a particle cloud (a "poof" of particles from the center)
	particles.z_index = 100 
	particles.z_as_relative = false 
	particles.amount = 20
	particles.lifetime = 0.5
	particles.explosiveness = 1.0
	particles.one_shot = true
	particles.scale_amount_min = 10.0 
	particles.scale_amount_max = 20.0
	particles.spread = 180.0
	particles.gravity = Vector2(0, 0)
	particles.initial_velocity_min = 80.0
	particles.initial_velocity_max = 150.0
	particles.damping_min = 50.0 

	# Design the shape of the cloud (the "poof")
	var curve = Curve.new()
	curve.add_point(Vector2(0, 1.0)) 
	curve.add_point(Vector2(1, 0.0))
	particles.scale_amount_curve = curve

	# Design the colours of the cloud
	var gradient = Gradient.new()
	gradient.add_point(0.0, Color(1, 1, 1, 1)) 
	gradient.add_point(1.0, Color(1, 1, 1, 0)) 
	particles.color_ramp = gradient

	particles.emitting = true
	
	var timer = get_tree().create_timer(particles.lifetime + 0.5)
	timer.timeout.connect(particles.queue_free)
	
