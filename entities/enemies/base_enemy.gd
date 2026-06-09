class_name Enemy extends Area2D

@export var max_health := 100.0
@onready var health = max_health
@onready var health_bar := $UI/HealthBar
@export var projectile_scene: PackedScene
@onready var timer = $Timer
@onready var spawn_point = $Marker2D
@export var enemy_speed := 20.0  # enemy speed


# Signal
signal enemy_died

var player = null # player node
var direction := Vector2(0, 0)
var rotation_speed := 1.0



func _ready() -> void:
	
	health = max_health
	health_bar.max_value = max_health
	health_bar.value = health
	player = get_tree().get_first_node_in_group("Player")
	timer.wait_time = 1.0
	timer.start()


		
		
		
func _physics_process(delta: float) -> void:
	if player == null:
		return
	#
	#if is_boss:
		#look_at(player.global_position)
		#rotation += deg_to_rad(90)
		#direction = (player.global_position - global_position).normalized()
		#var velocity := (direction * enemy_speed)
		#global_position += (velocity * delta)
	
	# Finds player and moves towards player
	look_at(player.global_position)
	rotation += deg_to_rad(90)
	direction = (player.global_position - global_position).normalized()
	var velocity := (direction * enemy_speed)
	global_position += (velocity * delta)
	

func shoot_at_player() -> void:
	if player == null:
		return
	#for markers in boss_shooter:
		#print(markers)
	
	# Instantiate and adds projectile (bullet) to scene
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = spawn_point.global_position
	var direction = (player.global_position - global_position).normalized()
	projectile.direction = direction
	

func _take_damage(amount: float) -> void:
	# updates enemy health and health_bar UI
	if (health - amount) <= 0:
		health = 0.0
		health_bar.value = health
		enemy_died.emit()
		queue_free()
	else:
		health -= amount
		health_bar.value = health
		# instantiating damage_pop scene
		var damage_indicator: Node2D = preload("res://ui/damage_popup.tscn").instantiate()
		get_tree().current_scene.add_child(damage_indicator)
		damage_indicator.global_position = global_position
		damage_indicator.display_damage(amount)
		spawn_poof()




func _on_timer_timeout() -> void:
	# call shoot method when timer finishes
	shoot_at_player()
	


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
	
