class_name Hit_Box extends Area2D

signal Player_is_near()

@export var damage : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect( Entered_area )
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Entered_area ( body : Area2D ) -> void:
	if body is Hurt_Box:
		Player_is_near.emit()
		body.Get_damage( damage )
