class_name Player extends Area2D

var normal_speed := 900.0
@export var max_speed := normal_speed
var velocity := Vector2(0, 0)
var steering_factor := 10.0
var mouse_global_pos: Vector2
var shooter_1_state: bool = true
var shooter_2_state: bool = false
var player_max_health := 100.0
var player_health := 50.0
var kill_count: int = 0

@export var projectile_scene: PackedScene
@onready var spawn_point = $Marker2D
@onready var spawn_point_2 = $Marker2D2
@onready var health_bar = $UI/HealthBar
@onready var ui_node = $UI

func _ready() -> void:
	kill_count = 0
	health_bar.max_value = player_max_health
	health_bar.value = player_health
	
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
		#GameManager.show_end_screen("Game Over")
		
	else:
		player_health -= amount
		health_bar.value = player_health
		print(player_health)
	
	
func kill_amount(kill_count: int) -> void:
	pass


func set_health(new_health: int) -> void:
	player_health = new_health
	# Find the bar and update its 'value' property
	health_bar.value = player_health


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("health_pack"):
		set_health(player_health + 15)
		print("health pack")
