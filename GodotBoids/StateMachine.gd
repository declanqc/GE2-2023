class_name StateMachine extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var initial_state:NodePath

var current_state:State
var global_state:State
var previous_state:State

func change_state(var new_state):
	if current_state:
		current_state._exit()
	current_state = new_state
	if current_state:
		current_state._enter()
	
func _ready():
	if initial_state:
		current_state = get_node(initial_state)
		change_state(current_state)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	DebugDraw.set_text(get_parent().name, current_state.name)
	if current_state:
		current_state._think()
	if global_state:
		global_state._think()