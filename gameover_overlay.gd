extends CanvasLayer



func _ready() -> void:
	#keep overlay hidden
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func display_game_over() -> void:
	show()
	#Pauses the game temporarily
	get_tree().paused= true

func _on_restart_pressed() -> void:
	get_tree().paused=false
	get_tree().reload_current_scene()
	


func _on_quit_pressed() -> void:
	get_tree().quit()
