extends RigidBody3D

class_name Shell

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	print("Signal Connected")
	
func _physics_process(_delta: float) -> void:
	var impulse_vector: Vector3 = global_position + linear_velocity
	if (global_position != impulse_vector and !is_queued_for_deletion()):
		look_at(global_position + linear_velocity, Vector3.UP, true)



func _on_body_entered(body: PhysicsBody3D) -> void:
	#debugging collisions cos it wasn't working
	print("Collided with: ", body.name)
	queue_free()
	if(body.is_in_group("Shellable")):
		body.queue_free()
