extends Node

func _ready() -> void:
	Player_Manager.Add_player_to_scene()
	await get_tree().process_frame

func Load_end_screen() -> void:
	get_tree().paused = true
	await get_tree().process_frame
	
	Player_Hud.End_game()
	End_Screen.Fading()
	await get_tree().process_frame
