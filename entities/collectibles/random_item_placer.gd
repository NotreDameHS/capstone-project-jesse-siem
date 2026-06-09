extends Node2D
@onready var timer = $Timer
# Cache the preloaded scenes for better performance
var item_scenes: Array[PackedScene] = [
	preload("res://entities/collectibles/health_pack.tscn"),
	preload("res://entities/collectibles/invisible_shield.tscn"),
	preload("res://entities/collectibles/weapon_upgrade.tscn")
]

func _ready() -> void:
	pass

func _on_timer_timeout() -> void:
	# 1. Pick and instantiate a random scene
	var random_item_scene: PackedScene = item_scenes.pick_random()
	var item_instance: Node2D = random_item_scene.instantiate()
	add_child(item_instance)
	
	# 2. Get the viewport bounds
	var viewport_size: Vector2 = get_viewport_rect().size
	
	# 3. Generate and assign a random position
	var random_position := Vector2(
		randf_range(0.0, viewport_size.x),
		randf_range(0.0, viewport_size.y)
	)
	
	item_instance.position = random_position
