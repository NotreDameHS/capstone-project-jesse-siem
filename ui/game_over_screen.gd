extends CanvasLayer

@onready var title_label: Label = $CenterContainer/TitleLabel

func set_title(text: String) -> void:
	title_label.text = text
	
func _ready() -> void:
	get_tree().paused = true
	
		
