extends Node

const SAVE_PATH = "user://"

#signal game_was_loaded
#signal game_was_saved

var load_operation : bool = false

var current_saving_data : Dictionary = {
	scene_path = "",
	player = { health_points = 3, position_x = 0, position_y = 0},
	items = [],
	activated_interactive_objets = []
}

func Update_current_saving_data() -> void:
	var player : Player = Player_Manager.player
	current_saving_data.player.health_points = player.health_points
	current_saving_data.player.position_x = player.global_position.x
	current_saving_data.player.position_y = player.global_position.y
	
	current_saving_data.items = Player_Manager.PLAYER_INVENTORY.Group_items_to_save()

func Save_game() -> void:
	Update_current_saving_data()
	
	var file := FileAccess.open( SAVE_PATH + "Save.sav", FileAccess.WRITE )
	var data = JSON.stringify( current_saving_data )
	file.store_line( data )
	#game_was_saved.emit()

func Load_game() -> void:
	var file := FileAccess.open( SAVE_PATH + "Save.sav", FileAccess.READ )
	var json_data = JSON.new()
	json_data.parse( file.get_line() )
	current_saving_data = json_data.get_data() as Dictionary
	
	get_tree().change_scene_to_file("res://game.tscn")
	await get_tree().process_frame
	load_operation = true
	
	Player_Manager.Add_player_to_scene()
	Player_Manager.Set_player_position( Vector2( current_saving_data.player.position_x, current_saving_data.player.position_y ) )
	Player_Manager.Set_player_health_points( load_operation, current_saving_data.player.health_points )
	Player_Manager.PLAYER_INVENTORY.Ungroup_items_to_load( current_saving_data.items )
	
	#game_was_loaded.emit()
	load_operation = false
