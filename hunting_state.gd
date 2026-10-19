extends State

class_name HuntingState

func _shouldChangeState(monitored_object:AITank) -> bool:
	return monitored_object.target != null

func determineNextState(monitored_object)-> String:
	return "Firing"
	

func onChangeState(monitored_object):
	print("Hunting")
	monitored_object.idle= true
	monitored_object.rotate_turret(0)

func process(monitored_object:AITank):
	if(monitored_object.idle):
		monitored_object.nearest_nav_point= monitored_object.get_random_navpoint()
		monitored_object.idle = false
	else:
		if(!monitored_object.has_reached_destination()):
			if(!monitored_object.is_facing_destination()):
				#check/debug positive vs negative values to set turn speed
				#which turns the tank 
				monitored_object.set_turn_speed(1)
			else:
				#move tank towards player, don't turn tank
				monitored_object.set_turn_speed(0)
				monitored_object.set_move_speed(1)
		else:
			monitored_object.idle = true
			monitored_object.set_move_speed(0)
