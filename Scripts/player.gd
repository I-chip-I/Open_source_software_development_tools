class_name Player extends CharacterBody2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer

@onready var sprite_player_walking_down : Sprite2D = $Sprite2D_walking_down
@onready var sprite_player_walking_up : Sprite2D = $Sprite2D_walking_up
@onready var sprite_player_walking_side : Sprite2D = $Sprite2D_walking_side
@onready var sprite_player_standing_down : Sprite2D = $Sprite2D_standing_down
@onready var sprite_player_standing_up : Sprite2D = $Sprite2D_standing_up
@onready var sprite_player_standing_side : Sprite2D = $Sprite2D_standing_side

var current_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var move_speed : float = 250.0
var state : String = "standing"
var current_sprite : Sprite2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	current_sprite = sprite_player_standing_down
	current_sprite.visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( delta ):
	
	direction.x = Input.get_action_raw_strength("Right") - Input.get_action_raw_strength("Left")
	direction.y = Input.get_action_raw_strength("Down") - Input.get_action_raw_strength("Up")
	
	velocity = direction * move_speed
	
	if Set_state() == true || Set_direction() == true:
		Update_sprite()
		current_sprite.visible = true
		Update_animation()
	
	pass

func _physics_process( delta ):
	move_and_slide()

func Set_direction() -> bool:
	
	var new_direction : Vector2 = current_direction
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
	
	if new_direction == current_direction:
		return false
	
	current_direction = new_direction
	return true

func Set_state() -> bool:
	
	var new_state : String
	
	if direction == Vector2.ZERO:
		new_state = "standing"
	else:
		new_state = "walking"
	
	if new_state == state:
		return false
	
	state = new_state
	return true

func Update_sprite() -> void:
	current_sprite.visible = false
	
	if state == "standing":
		match current_direction:
			Vector2.DOWN:
				current_sprite = sprite_player_standing_down
			Vector2.UP:
				current_sprite = sprite_player_standing_up
			_:
				current_sprite = sprite_player_standing_side
	elif state == "walking":
		match current_direction:
			Vector2.DOWN:
				current_sprite = sprite_player_walking_down
			Vector2.UP:
				current_sprite = sprite_player_walking_up
			_:
				current_sprite = sprite_player_walking_side
		
	if current_direction == Vector2.LEFT:
		current_sprite.flip_h = true
	else:
		current_sprite.flip_h = false

func Update_animation() -> void:
	animation_player.play(state + "_" + Get_animation_direction())
	pass

func Get_animation_direction() -> String:
	if current_direction == Vector2.DOWN:
		return "down"
	elif current_direction == Vector2.UP:
		return "up"
	else:
		return "side"
