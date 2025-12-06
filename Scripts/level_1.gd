class_name Level_1 extends Node2D

func _ready() -> void:
	self.y_sort_enabled = true
	Player_Manager.Set_parent_node( self )

func Free_level() -> void:
	queue_free()
