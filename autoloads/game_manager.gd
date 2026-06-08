extends Node
signal health_changed(amount: int)
const GAME_OVER_SCREEN = preload("res://ui/game_over_screen.tscn")



#inital player health
var player_health = 100


#enemys health
var BaseEnemy_health: int = 5
var strongEnemy_health: int = 10
var finalBoss_health: int = 15





func BaseEnemy_lose_life() -> void:
	BaseEnemy_health -= 1
	health_changed.emit(BaseEnemy_health)
	
func strongEnemy_lose_life() -> void:
	strongEnemy_health -= 1
	health_changed.emit(strongEnemy_health)
	
func finalBoss_lose_life() -> void:
	finalBoss_health -= 1
	health_changed.emit(finalBoss_health)		
		

func show_end_screen(message: String) -> void:
	var screen = GAME_OVER_SCREEN.instantiate()
	get_tree().current_scene.add_child(screen)
	screen.set_title(message)
