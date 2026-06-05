class_name Enemy extends Area2D
# 
@export var max_health := 100.0
@export var health = max_health
@onready var health_bar := $UI/HealthBar
@export var projectile_scene: PackedScene
@onready var timer = $Timer
@onready var spawn_point = $Marker2D
@export var enemy_speed := 20.0  # enemy speed
@export var is_boss := false
var rotation_speed := 4.0



# Signal
signal enemy_died

var player = null # player node
var direction := Vector2(0, 0)

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
	
	if is_boss:
		rotation += rotation_speed * delta
		direction = (player.global_position - global_position).normalized()
		var velocity := (direction * enemy_speed)
		global_position += (velocity * delta)
	
	
	else:	
		# Finds player and moves towards player
		look_at(player.global_position)
		rotation += deg_to_rad(90)
		direction = (player.global_position - global_position).normalized()
		var velocity := (direction * enemy_speed)
		global_position += (velocity * delta)
	

func shoot_at_player() -> void:
	if player == null:
		return
		
		
		
		
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
		
		
		
		

func _on_timer_timeout() -> void:
	# call shoot method when timer finishes
	shoot_at_player()
	
