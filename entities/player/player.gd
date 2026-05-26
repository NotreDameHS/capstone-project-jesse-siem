extends Area2D

var normal_speed := 900.0
var max_speed := normal_speed
var velocity := Vector2(0, 0)
var steering_factor := 10.0


func _proccess(delta: float) -> void:
	var direction := Vector2(0, 0)
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
