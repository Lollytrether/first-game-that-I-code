extends Node3D

@export
var player: Player_Tank
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_key_input(event: InputEvent) -> void:
	var turn_value:float = Input.get_axis("ui_right", "ui_left")
	var move_value:float = Input.get_axis("ui_up", "ui_down")
	
	player.set_move_speed(move_value)
	player.set_turn_speed(turn_value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
