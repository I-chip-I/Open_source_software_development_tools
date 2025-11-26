class_name Enemy_State_Standing extends Enemy_State

@onready var walking : Enemy_State = $"../Walking"

@export var min_state_duration : float = 0.8
@export var max_state_duration : float = 1.6

var timer : float = 0.0

func Enter() -> void:
	enemy.velocity = Vector2.ZERO
	timer = randf_range( min_state_duration, max_state_duration )
	enemy.Update_sprite( "standing" )
	enemy.current_sprite.visible = true
	enemy.Update_animation( "standing" )

func Exit() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Process( delta : float ) -> Enemy_State:
	timer = timer - delta
	if timer <= 0:
		return walking
	
	return null

#func Physics( delta : float ) -> State:
#	return null
