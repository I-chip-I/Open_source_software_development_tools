class_name Enemy_State_Attacking extends Enemy_State

@onready var walking : Enemy_State = $"../Walking"

@export var decreased_speed : float = 300.0
var end_of_animation : bool

func Enter() -> void:
	end_of_animation = false
	enemy.velocity = Vector2.ZERO
	enemy.Update_sprite( "attacking" )
	enemy.current_sprite.visible = true
	enemy.Update_animation( "attacking" )
	
	await get_tree().create_timer( 0.6 ).timeout
	end_of_animation = true


func Exit() -> void:
	pass


func Process( delta : float ) -> Enemy_State:
	if end_of_animation == true:
		return walking
	
	return null
