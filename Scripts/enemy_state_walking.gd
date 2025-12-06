class_name Enemy_State_Walking extends Enemy_State

@export var move_speed : float = 500.0
@onready var standing : Enemy_State = $"../Standing"

@export var state_duration : float = 1.0
@export var  min_animation_cycles : int = 1
@export var  max_animation_cycles : int = 3

var timer : float = 0.0
var walking_direction : Vector2


func Enter() -> void:
	timer = randi_range( min_animation_cycles, max_animation_cycles ) * state_duration
	walking_direction = enemy.all_directions[ randi_range( 0, 3 ) ]
	enemy.Set_direction( walking_direction )
	enemy.velocity = walking_direction * move_speed
	
	enemy.Update_sprite( "walking" )
	enemy.current_sprite.visible = true
	enemy.Update_animation( "walking" )

func Exit() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Process( delta : float ) -> Enemy_State:
	
	timer = timer - delta
	if timer <= 0:
		return standing
	
	return null

#func Physics( delta : float ) -> State:
#	return null
