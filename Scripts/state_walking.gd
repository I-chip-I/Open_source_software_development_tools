class_name State_Walking extends State

@export var move_speed : float = 300.0
@onready var standing : State = $"../Standing"

func Enter() -> void:
	pass

func Exit() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Process( delta : float ) -> State:
	if player.direction == Vector2.ZERO:
		return standing
	
	player.velocity = player.direction * move_speed
	
	player.Set_direction()
	player.Update_sprite( "walking" )
	player.current_sprite.visible = true
	player.Update_animation( "walking" )
	
	return null

#func Physics( delta : float ) -> State:
#	return null

#func HandleInput ( event : Inputevent ) -> State:
#	return null
