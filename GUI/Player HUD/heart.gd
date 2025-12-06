class_name Heart extends Control

@onready var sprite_full_health : Sprite2D = $Sprite2D_full_health
@onready var sprite_low_health : Sprite2D = $Sprite2D_low_health
var current_sprite : Sprite2D = null

func _ready() -> void:
	current_sprite = sprite_full_health

func Update_sprite_for_damage() -> void:
	current_sprite.visible = false
	current_sprite = sprite_low_health
	current_sprite.visible = true

func Update_sprite_for_restore() -> void:
	current_sprite.visible = false
	current_sprite = sprite_full_health
	current_sprite.visible = true
