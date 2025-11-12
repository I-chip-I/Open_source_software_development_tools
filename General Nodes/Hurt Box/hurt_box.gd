class_name Hurt_Box extends Area2D

signal Was_damaged ( damage : int )

func _ready() -> void:
	pass

func _process( delta ):
	pass

func Get_damage ( damage : int ) -> void:
	Was_damaged.emit( damage )
	pass
