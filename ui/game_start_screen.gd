extends CanvasLayer
@onready var title_label: Label = $CenterContainer/Label
@onready var timer = $Timer
var count = 3

	
func _ready() -> void:
	get_tree().paused = true
	start_countdown()


func start_countdown()-> void:
	title_label.text = str(count)
	timer.start()
	
	
func _on_timer_timeout() -> void:
	count -= 1
	if count > 0:
		title_label.text = str(count)
		timer.start()
	elif count == 0:
		title_label.text = "GO!"
		remove_screen()

func remove_screen():
	queue_free() # Removes the countdown screen
	get_tree().paused = false # Unpause game
	
