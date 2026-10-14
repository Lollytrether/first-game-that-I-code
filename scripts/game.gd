extends Node3D

@export
var player:Tank

func _ready():
	player.SHELL_FIRED.connect(_on_shell_fired)
	
func _unhandled_key_input(event):
	var turn_value:float = Input.get_axis("ui_right", "ui_left")
	var move_value:float = Input.get_axis("ui_down", "ui_up")
	
	if (Input.is_physical_key_pressed(KEY_CTRL)):
		player.rotate_turret(turn_value)
		player.angle_turret(move_value)
		
		player.set_turn_speed(0)
		player.set_move_speed(0)
	else:
		player.rotate_turret(0)
		player.angle_turret(0)
		
		player.set_turn_speed(turn_value)
		player.set_move_speed(move_value)
	if (Input.is_action_just_pressed("ui_accept") and !player.reloading):
		player.fire_shell(1)

func _on_shell_fired(shell:Shell):
	add_child(shell)
