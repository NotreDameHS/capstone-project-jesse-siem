extends Projectile
class_name UpgradedRocket

# How fast the rocket can turn towards its target (higher = sharper turns)
@export var turning_speed := 4.0
# Max distance to search for a new target if the current one dies
@export var search_radius := 250.0

#var target: Mob = null

func _physics_process(delta: float) -> void:
	# 1. Find or update our tracking target
	#if target == null or not is_instance_valid(target):
		_find_nearest_mob()
		
	# 2. Smoothly rotate towards the target if one exists
	#if target != null:
		#var target_angle = (target.global_position - global_position).angle()
		# lerp_angle automatically calculates the shortest rotation path
		#rotation = lerp_angle(rotation, target_angle, turning_speed * delta)
		
	# 3. Execute base projectile movement, distance tracking & explosion logic
	#super._physics_process(delta)

func _find_nearest_mob() -> void:
	var closest_mob = null
	var shortest_dist = search_radius
	
	# Search all active mobs in the scene
	for node in get_tree().get_nodes_in_group("mobs"):
		#if node is Mob:
			var dist = global_position.distance_to(node.global_position)
			if dist < shortest_dist:
				shortest_dist = dist
				closest_mob = node
				
	#target = closest_mob
