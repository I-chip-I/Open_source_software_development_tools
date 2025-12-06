class_name State_Hurt extends State

@onready var standing : State = $"../Standing"
@onready var walking : State = $"../Walking"

@export var knock_back_speed : float = 300.0
@export var is_invulnerable : bool
var end_of_animation : bool

func Enter() -> void:
	is_invulnerable = true
	end_of_animation = false
	player.velocity = player.direction * -knock_back_speed
	
	player.Update_sprite( "hurt" )
	player.current_sprite.visible = true
	player.Update_animation( "hurt" )
	
	await get_tree().create_timer( 0.7 ).timeout
	end_of_animation = true

func Exit() -> void:
	is_invulnerable = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Process( delta : float ) -> State:
	if end_of_animation == true && player.direction != Vector2.ZERO:
		return walking
	elif end_of_animation == true && player.direction == Vector2.ZERO:
		return standing
	
	return null
