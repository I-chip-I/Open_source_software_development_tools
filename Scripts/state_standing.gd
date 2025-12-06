class_name State_Standing extends State

@onready var walking : State = $"../Walking"

func Enter() -> void:
	player.Update_sprite( "standing" )
	player.current_sprite.visible = true
	player.Update_animation( "standing" )

func Exit() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Process( delta : float ) -> State:
	if player.direction != Vector2.ZERO:
		return walking
	
	player.velocity = Vector2.ZERO
	return null
