class_name Enemy extends CharacterBody2D

@onready var animation_enemy : AnimationPlayer = $AnimationPlayer

@onready var sprite_enemy_walking_down : Sprite2D = $Sprite2D_walking_down
@onready var sprite_enemy_walking_up : Sprite2D = $Sprite2D_walking_up
@onready var sprite_enemy_walking_side : Sprite2D = $Sprite2D_walking_side
@onready var sprite_enemy_standing_down : Sprite2D = $Sprite2D_standing_down
@onready var sprite_enemy_standing_up : Sprite2D = $Sprite2D_standing_up
@onready var sprite_enemy_standing_side : Sprite2D = $Sprite2D_standing_side

@onready var sprite_enemy_attacking_down : Sprite2D = $Sprite2D_attacking_down
@onready var sprite_enemy_attacking_up : Sprite2D = $Sprite2D_attacking_up
@onready var sprite_enemy_attacking_side : Sprite2D = $Sprite2D_attacking_side
@onready var enemy_state_machine : Enemy_State_Machine = $Enemy_State_Machine
@onready var attacking : Enemy_State = $Enemy_State_Machine/Attacking
@onready var hit_box : Hit_Box = $Interactions/HitBox

var character_direction : Vector2 = Vector2.DOWN
const all_directions = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]
var direction : Vector2 = Vector2.ZERO
var current_sprite : Sprite2D = null

signal Direction_changed( new_direction : Vector2 )
var player : Player

func _ready() -> void:
	current_sprite = sprite_enemy_standing_down
	current_sprite.visible = true
	
	player = Player_Manager.player
	enemy_state_machine.Initialize_state( self )
	hit_box.Player_is_near.connect( Attack_player )
	hit_box.monitoring = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process( delta ):
	move_and_slide()

func Set_direction( current_direction : Vector2 ) -> bool:
	direction = current_direction
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
				current_sprite = sprite_enemy_standing_down
			Vector2.UP:
				current_sprite = sprite_enemy_standing_up
			_:
				current_sprite = sprite_enemy_standing_side
	elif state == "walking":
		match character_direction:
			Vector2.DOWN:
				current_sprite = sprite_enemy_walking_down
			Vector2.UP:
				current_sprite = sprite_enemy_walking_up
			_:
				current_sprite = sprite_enemy_walking_side
	elif state == "attacking":
		match character_direction:
			Vector2.DOWN:
				current_sprite = sprite_enemy_attacking_down
			Vector2.UP:
				current_sprite = sprite_enemy_attacking_up
			_:
				current_sprite = sprite_enemy_attacking_side
		
	if character_direction.x < 0:
		current_sprite.flip_h = true
	else:
		current_sprite.flip_h = false

func Update_animation(state : String) -> void:
	animation_enemy.play(state + "_" + Get_animation_direction())
	pass

func Get_animation_direction() -> String:
	if character_direction == Vector2.DOWN:
		return "down"
	elif character_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func Attack_player() -> void:
	enemy_state_machine.Change_state( attacking )
