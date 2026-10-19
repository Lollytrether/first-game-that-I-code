extends Tank

class_name AITank

var target:CharacterBody3D
var idle:bool
var nearby_nav_points:Array[StaticBody3D] = []
var nearest_nav_point:StaticBody3D
@export
var sightLine:RayCast3D
@export 
var targetLine:RayCast3D
func _on_targetting_area_body_entered(body) -> void:
	target = body


func _on_targetting_area_body_exited(body) -> void:
	target = null


func _on_movement_area_body_entered(body: Node3D) -> void:
	nearby_nav_points.append(body)


func _on_movement_area_body_exited(body: Node3D) -> void:
	nearby_nav_points.erase(body)
	
func get_random_navpoint() -> StaticBody3D:
	var navpoint = null
	
	#more for debugging but makes sure that there is a nav point 
	if (nearby_nav_points.size() > 0 ):
		#If the navpoint is equal to the same navpoint or there is none 
		while navpoint == nearest_nav_point or navpoint == null:
			#get a navpoint, between (inclusive) the first and the last element of the array  
			navpoint = nearby_nav_points[randi_range(0, nearby_nav_points.size() - 1)]
	return navpoint
	
func has_reached_destination() -> bool:
	#returns that if the enemy tank is less than 1 frames distance of movement
	# to the navpoint, the distance between them (aka, if the enemy tank is basically at the navpoint)
	return nearest_nav_point.global_position.distance_to(global_position) <= 1.1

func is_facing_destination() -> bool:
	#this finds the vector between the nav point and enemy tank 
	#By subtracting the nav points global position to the enemy tank's global position,
	#normalise's the vector which returns the unit length (smallest length)
	#We then get that vector's angle between the enemy tank's current facing direction
	#And the nav point
	#If the angle is less than 1 degree (deg to rad value), it's facing the navpoint/destination
	var facing_vector = (nearest_nav_point.global_position - global_position).normalized()
	return facing_vector.angle_to(transform.basis.z) <= deg_to_rad(1)
