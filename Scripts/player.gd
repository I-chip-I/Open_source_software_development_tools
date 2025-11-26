class_name Player extends CharacterBody2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite_player_standing_down : Sprite2D = $Sprite2D_standing_down
@onready var sprite_player_standing_up : Sprite2D = $Sprite2D_standing_up
@onready var sprite_player_standing_side : Sprite2D = $Sprite2D_standing_side
@onready var sprite_player_walking_down : Sprite2D = $Sprite2D_walking_down
@onready var sprite_player_walking_up : Sprite2D = $Sprite2D_walking_up
@onready var sprite_player_walking_side : Sprite2D = $Sprite2D_walking_side
@onready var sprite_player_hurt_down : Sprite2D = $Sprite2D_hurt_down
@onready var sprite_player_hurt_up : Sprite2D = $Sprite2D_hurt_up
@onready var sprite_player_hurt_side : Sprite2D = $Sprite2D_hurt_side
@onready var sprite_player_dead : Sprite2D = $Sprite2D_dead
@onready var state_machine : Player_State_Machine = $State_Machine
@onready var hurt : State = $State_Machine/Hurt
@onready var dead : State = $State_Machine/Dead
@onready var hurt_box : Hurt_Box = $HurtBox

var character_direction : Vector2 = Vector2.DOWN
const all_directions = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]
var direction : Vector2 = Vector2.ZERO
var current_sprite : Sprite2D = null

signal Direction_changed( new_direction : Vector2 )

@export var health_points : int = 3
var is_invulnerable : bool = false

func _ready():
	current_sprite = sprite_player_standing_down
	current_sprite.visible = true
	
	Player_Manager.player = self
	state_machine.Initialize_state( self )
	hurt_box.Was_damaged.connect( Got_damage )


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( delta ):
	direction = Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down")).normalized()

func _physics_process( delta ):
	move_and_slide()

func Set_direction() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	var i_direction : int = int( round( ( direction + character_direction * 0.1 ).angle() / (2*PI) * all_directions.size() ) )
	var new_direction : Vector2 = all_directions[ i_direction ]
	
	if new_direction == character_direction:
		return false
	
	character_direction = new_direction
	Direction_changed.emit( character_direction )
	return true

func Update_sprite( state : String ) -> void:
	current_sprite.visible = false
	
	if state == "standing":
		match character_direction:
			Vector2.DOWN:
				current_sprite = sprite_player_standing_down
			Vector2.UP:
				current_sprite = sprite_player_standing_up
			_:
				current_sprite = sprite_player_standing_side
	elif state == "walking":
		match character_direction:
			Vector2.DOWN:
				current_sprite = sprite_player_walking_down
			Vector2.UP:
				current_sprite = sprite_player_walking_up
			_:
				current_sprite = sprite_player_walking_side
	elif state == "hurt":
		match character_direction:
			Vector2.DOWN:
				current_sprite = sprite_player_hurt_down
			Vector2.UP:
				current_sprite = sprite_player_hurt_up
			_:
				current_sprite = sprite_player_hurt_side
	elif state == "dead":
		current_sprite = sprite_player_dead
		
	if character_direction.x < 0:
		current_sprite.flip_h = true
	else:
		current_sprite.flip_h = false

func Update_animation(state : String) -> void:
	if state != "dead":
		animation_player.play(state + "_" + Get_animation_direction())
	else:
		animation_player.play(state)

func Get_animation_direction() -> String:
	if character_direction == Vector2.DOWN:
		return "down"
	elif character_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func Got_damage( damage : int ) -> void:
	if is_invulnerable == true:
		return
	
	health_points = health_points - damage
	
	if health_points > 0:
		state_machine.Change_state( hurt )
	else:
		print("Dead")
		state_machine.Change_state( dead )
