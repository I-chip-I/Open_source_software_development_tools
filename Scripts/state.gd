class_name State extends Node

static var player : Player

func _ready() -> void:
	pass

func Enter() -> void:
	pass

func Exit() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Process( delta : float ) -> State:
	return null


#func Physics( delta : float ) -> State:
#	return null

#func HandleInput ( event : Inputevent ) -> State:
#	return null
