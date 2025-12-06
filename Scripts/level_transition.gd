class_name Level_Transition extends Area2D

func _ready() -> void:
	body_entered.connect( Player_entered_area )

func Player_entered_area( body : CharacterBody2D ) -> void:
	if body is Player:
		Level_Manager.Load_end_screen()
