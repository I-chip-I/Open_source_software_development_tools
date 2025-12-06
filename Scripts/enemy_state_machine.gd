class_name Enemy_State_Machine extends Node

var states : Array[ Enemy_State ]
var last_state : Enemy_State
var current_state : Enemy_State

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED


func _process(delta: float) -> void:
	Change_state( current_state.Process( delta ) )

#func _physics_process( delta ):
	#Change_state( current_state.Physics( delta ) )
	#pass

func Initialize_state( enemy : Enemy ) -> void:
	states = []
	
	for i in get_children():
		if i is Enemy_State:
			states.append(i)
	
	for i in states:
		i.enemy = enemy
		i.state_machine = self
		i.Init()
	
	if states.size() > 0:
		Change_state( states[0] )
		process_mode = Node.PROCESS_MODE_INHERIT


func Change_state( new_state : Enemy_State) -> void:
	if new_state == null:
		return
	
	if current_state != null:
		current_state.Exit()
	
	last_state = current_state
	current_state = new_state
	current_state.Enter()
