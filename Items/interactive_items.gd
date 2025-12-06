@tool
class_name Interactive_Items extends Node2D

@onready var item_area : Area2D = $Area2D
@onready var item_sprite : Sprite2D = $Sprite2D

@export var item_data : Item :  set = Set_item


func _ready() -> void:
	Update_texture()
	
	if Engine.is_editor_hint():
		return
	
	item_area.body_entered.connect( Entered_item_area )



func Set_item( data : Item ) -> void:
	item_data = data
	Update_texture()


func Update_texture() -> void:
	if item_data != null && item_sprite != null:
		item_sprite.texture = item_data.item_texture
	pass


func Entered_item_area( body : Player ) -> void:
	if body is Player:
		if item_data != null:
			if Player_Manager.PLAYER_INVENTORY.Add_item( item_data ) == true:
				Was_picked_up()

func Was_picked_up() -> void:
	item_area.body_entered.disconnect( Entered_item_area )
	visible = false
	queue_free()
