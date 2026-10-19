extends CharacterBody3D

class_name Tank

signal SHELL_FIRED(shell:Shell)

@export_group("Tank body")
## Tank turn speed in degrees
@export
var turn_speed_degrees:float = 90

## Tank's movement speed in units per second
@export
var move_speed:float = 10

@export_group("Turret")
## Tank turret xz axis rotation
@export
var turret_move_speed:float = 20
## Tank turret y axis tilt
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
var reloading:bool
@export_group("Shell")
@export var shell_prefab: PackedScene
@export var shell_fire_point: Marker3D
@export var muzzle_velocity: int = 20
@export var reload_timer:Timer


func _physics_process(delta):
	rotation_degrees += Vector3(0, rotation_speed * delta, 0)
	velocity = transform.basis.z * forward_speed
	
	#rotates on the y axis 
	turret.rotation_degrees += Vector3(0, turret_rotation_speed * delta, 0)
	#rotates on the z-axis
	turret_hinge.rotation_degrees += Vector3(0, 0, turret_angle_speed * delta)
	
	#Stops the turret tilt to the angle
	turret_hinge.rotation_degrees.z = clampf(turret_hinge.rotation_degrees.z, -turret_max_angle_degrees, turret_max_angle_degrees)

	move_and_collide(velocity*delta)

#defining a function when the turn key is pressed, the input direction and predefined
#constant angle acceleration are multiplied to get the rotation velocity 
func set_turn_speed(input_value:float):
	rotation_speed = turn_speed_degrees * input_value


func set_move_speed(input_value:float):
	forward_speed = move_speed * input_value


func rotate_turret(input_value:float):
	turret_rotation_speed = turret_move_speed * input_value


func angle_turret(input_value:float):
	turret_angle_speed = turret_move_speed * input_value
	

func fire_shell(ignore_layer:int):
	if (reloading):
		return
	var shell:Shell = shell_prefab.instantiate()
	var impulse:Vector3 = Vector3.BACK* muzzle_velocity
	shell.set_collision_mask_value(ignore_layer, false)
	SHELL_FIRED.emit(shell)
	
	shell.global_position = shell_fire_point.global_position
	shell.rotation = Vector3(-turret_hinge.rotation.z,rotation.y+ turret.rotation.y, 0)
	
	impulse = impulse.rotated(Vector3.RIGHT, shell.rotation.x)
	impulse = impulse.rotated(Vector3.UP, shell.rotation.y)
	shell.apply_central_impulse(impulse)
	
	reloading = true
	reload_timer.start()

func _on_reload_timer_timeout() -> void:
	reloading = false
