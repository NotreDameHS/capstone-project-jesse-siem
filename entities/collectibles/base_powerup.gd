extends Area2D





func _ready() -> void:
	play_floating_animation()
	
	
	
func play_floating_animation() -> void:	
	var tween := create_tween()
	var sprite_2d := get_node("Sprite2D")
	
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	
	var position_offset := Vector2(0.0, 4.0)
	var duration := randf_range(0.8,1.2)
	
	tween.tween_property(sprite_2d, "position", position_offset, duration)
	
	tween.tween_property(sprite_2d,"position", -1.0 * position_offset, duration)


func _on_area_entered(area: Area2D) -> void:
	queue_free()
