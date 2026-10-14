extends RigidBody3D

class_name Shell

	
func _physics_process(delta: float) -> void:
	var impulse_vector: Vector3 = global_position + linear_velocity
	if (global_position != impulse_vector and !is_queued_for_deletion()):
		look_at(global_position + linear_velocity, Vector3.UP, true)


func _on_body_entered(body: Node) -> void:
	queue_free()
