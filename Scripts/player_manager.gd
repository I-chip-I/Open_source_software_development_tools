extends Node

const PLAYER_SCENE = preload("res://Player/player.tscn")
const PLAYER_INVENTORY : Inventory = preload("res://GUI/Inventory/player_inventory.tres")

var player : Player
var was_spawned : bool = false

func _ready() -> void:
	await get_tree().create_timer( 0.3 ).timeout
	was_spawned = true


func Add_player_to_scene() -> void:
	player = PLAYER_SCENE.instantiate()
	add_child( player )


func Set_parent_node( new_parent_node : Node2D ) -> void:
	if player.get_parent():
		player.get_parent().remove_child( player )
	
	new_parent_node.add_child( player )


func Set_player_position( new_position : Vector2 ) -> void:
	player.global_position = new_position


func Set_player_health_points( load_operation : bool, health_points : int ) -> void:
	player.health_points = health_points
	Player_Hud.Update_health_points( load_operation, health_points )
