extends CharacterBody3D

class_name Player_Tank

## Tank turn speed in degrees
@export
var turn_speed_degrees:float = 20

## Tank's movement speed in units per second
@export
var move_speed:float = 10

@export
var turret_move_speed:float = 20

@export
var turret_max_angle_degrees:float = 15

@export
var turret:Node3D
@export
var turret_hinge:Node3D

var rotation_speed:float
var forward_speed:float

var turret_rotation_speed:float
var turret_angle_speed:float

func _physics_process(delta):
	rotation_degrees += Vector3(0, rotation_speed * delta, 0)
	velocity = transform.basis.x * forward_speed
	
	turret.rotation_degrees += Vector3(0, turret_rotation_speed * delta, 0)
	turret_hinge.rotation_degrees += Vector3(0, 0, turret_angle_speed * delta)
	
	turret_hinge.rotation_degrees.z = clampf(turret_hinge.rotation_degrees.z, -turret_max_angle_degrees, turret_max_angle_degrees)

	move_and_slide()


func set_turn_speed(input_value:float):
	rotation_speed = turn_speed_degrees * input_value


func set_move_speed(input_value:float):
	forward_speed = move_speed * input_value


func rotate_turret(input_value:float):
	turret_rotation_speed = turret_move_speed * input_value


func angle_turret(input_value:float):
	turret_angle_speed = turret_move_speed * input_value
