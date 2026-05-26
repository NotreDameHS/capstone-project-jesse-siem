extends Node2D

@onready var damage_label: Label = $Damage

func display_damage(amount: int) -> void:
	# shift x position 
	position.x += randf_range(-20.0, 20.0)
	
	# Set text to damage amount
	damage_label.text = str(amount)
	
