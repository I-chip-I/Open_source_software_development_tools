class_name Player_State_Machine extends Node

var states : Array[ State ]
var last_state : State
var current_state : State

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func _process( delta ):
	Change_state( current_state.Process( delta ) )

#func _physics_process( delta ):
	#Change_state( current_state.Physics( delta ) )
	#pass

#func _unhandled_input ( event ):
#	Change_state(current_state.HandleInput( event ) )
#	pass

func Initialize_state( player : Player ) -> void:
	states = []
	
	for i in get_children():
		if i is State:
			states.append(i)
	
	if states.size() > 0:
		states[0].player = player
		Change_state( states[0] )
		process_mode = Node.PROCESS_MODE_INHERIT

func Change_state( new_state : State) -> void:
	if new_state == null:
		return
	
	if current_state != null:
		current_state.Exit()
	
	last_state = current_state
	current_state = new_state
	current_state.Enter()
