class_name State

var state:State

func _process(delta):
	pass
	

func _isReadyToChangeState(monitored_object)->bool:
	return false
	
func process(monitored_object):
	pass
	
func onChangeState(monitored_object):
	pass
	
func determineNextState(monitored_object)-> String:
	return "default"
