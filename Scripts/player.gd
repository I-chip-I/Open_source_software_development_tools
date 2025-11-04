class_name Player extends CharacterBody2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer

@onready var sprite_player_walking_down : Sprite2D = $Sprite2D_walking_down
@onready var sprite_player_walking_up : Sprite2D = $Sprite2D_walking_up
@onready var sprite_player_walking_side : Sprite2D = $Sprite2D_walking_side
@onready var sprite_player_standing_down : Sprite2D = $Sprite2D_standing_down
@onready var sprite_player_standing_up : Sprite2D = $Sprite2D_standing_up
@onready var sprite_player_standing_side : Sprite2D = $Sprite2D_standing_side
@onready var state_machine : Player_State_Machine = $State_Machine

var character_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var current_sprite : Sprite2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	current_sprite = sprite_player_standing_down
	current_sprite.visible = true
	
	state_machine.Initialize_state( self )


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( delta ):
	
	direction.x = Input.get_action_raw_strength("Right") - Input.get_action_raw_strength("Left")
	direction.y = Input.get_action_raw_strength("Down") - Input.get_action_raw_strength("Up")

func _physics_process( delta ):
	move_and_slide()

func Set_direction() -> bool:
	
	var new_direction : Vector2
	if direction == Vector2.ZERO:
		return false
	
	if direction.y == 0:
		if direction.x < 0:
			new_direction = Vector2.LEFT
		else:
			new_direction = Vector2.RIGHT
	elif direction.x == 0:
		if direction.y < 0:
			new_direction = Vector2.UP
		else:
			new_direction = Vector2.DOWN
	
	if new_direction == character_direction:
		return false
	
	character_direction = new_direction
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
		
	if character_direction == Vector2.LEFT:
		current_sprite.flip_h = true
	else:
		current_sprite.flip_h = false

func Update_animation(state : String) -> void:
	animation_player.play(state + "_" + Get_animation_direction())
	pass

func Get_animation_direction() -> String:
	if character_direction == Vector2.DOWN:
		return "down"
	elif character_direction == Vector2.UP:
		return "up"
	else:
		return "side"
