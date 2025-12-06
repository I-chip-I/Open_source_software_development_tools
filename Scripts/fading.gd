extends CanvasLayer

@onready var animation : AnimationPlayer = $Control/AnimationPlayer
@onready var text : Label = $Control/Label

func _ready() -> void:
	text.visible = false

func Fading() -> void:
	animation.play("fading")
	await get_tree().create_timer( 0.6 ).timeout
	text.visible = true
