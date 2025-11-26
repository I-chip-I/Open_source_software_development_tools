class_name State_Dead extends State

@export var knock_back_speed : float = 100.0
var timer : float = 2.0

func Enter() -> void:
	player.velocity = player.direction * -knock_back_speed
	
	player.Update_sprite( "dead" )
	player.current_sprite.visible = true
	player.Update_animation( "dead" )

func Exit() -> void:
	pass

func Process( delta : float ) -> State:
	
	while timer >= 0:
		timer = timer - delta
	
	player.velocity = Vector2.ZERO
	return null
