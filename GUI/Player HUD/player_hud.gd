extends CanvasLayer

var hearts : Array[ Heart ] = []

func _ready() -> void:
	for i in $Control/HFlowContainer.get_children():
		if i is Heart:
			hearts.append( i )

func Update_health_points( load_operation : bool, health_points : int ) -> void:
	if load_operation == true:
		for i in hearts.size():
			if i < health_points:
				hearts[ i ].Update_sprite_for_restore()
			else:
				hearts[ i ].Update_sprite_for_damage()
	else:
		hearts[ health_points ].Update_sprite_for_damage()

func End_game() -> void:
	for i in $Control/HFlowContainer.get_children():
		if i is Heart:
			i.visible = false
