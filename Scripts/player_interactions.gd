class_name Player_Interactions extends Node2D

@onready var player : Player = $".."


func _ready():
	player.Direction_changed.connect( Update_direction )


# Called every frame. 'delta' is the elapsed time since the previous frame.
func Update_direction( new_direction : Vector2 ) -> void:
	match new_direction:
		Vector2.DOWN:
			rotation_degrees = 0
		Vector2.UP:
			rotation_degrees = 180
		Vector2.LEFT:
			rotation_degrees = 90
		Vector2.RIGHT:
			rotation_degrees = 270
		_:
			rotation_degrees = 0
	pass
