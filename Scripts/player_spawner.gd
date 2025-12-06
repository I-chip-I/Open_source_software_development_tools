extends Node2D

func _ready() -> void:
	visible = false
	if Player_Manager.was_spawned == false:
		Player_Manager.Set_player_position( global_position )
		Player_Manager.was_spawned = true
