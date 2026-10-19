extends State

class_name FiringState

func _shouldChangeState(monitored_object:AITank) -> bool:
	return monitored_object.target == null
 
func determineNextState(monitored_object:AITank)-> String:
	return "Hunting"
	monitored_object.rotate_turret(0)
	monitored_object.set_move_speed(0)

func onChangeState(monitored_object:AITank):
	print("Firing")
	
	
func process(monitored_object:AITank):
	monitored_object.sightLine.target_position= monitored_object.to_local(monitored_object.target.position)
	monitored_object.sightLine.force_raycast_update()
	
	if(monitored_object.sightLine.get_collider() == monitored_object.target):
		if(monitored_object.targetLine.get_collider() == null):
			#rotates clockwise, -1 for anti-clockwise, check the angle via
			#angle_to() computes the angle between two vectors that both start at (0,0).
			#It does not compute the angle at one of the points; it computes the angle between the directions of the vectors.
			monitored_object.rotate_turret(1)
		else:
			monitored_object.rotate_turret(0)
			#the parameter of fire shell is the layer to ignore when colliding
			monitored_object.fire_shell(0)
