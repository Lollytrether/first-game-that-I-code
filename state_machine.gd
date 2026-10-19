extends Node

class_name State_Machine

@export 
var states:Dictionary = {}
var state:State:
	set(value):
		state = value
		state.onChangeState(monitored_node)


var monitored_node

func _ready() -> void:
	monitored_node = get_parent()
	state = states["default"].new()
	
func _process(delta) -> void:
	if (state._shouldChangeState(monitored_node)):
		state = states[state.determineNextState(monitored_node)].new() 
	else:
		state.process(monitored_node)
