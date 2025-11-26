extends GutTest

func test_player_animation_direction():
	
	var PlayerScene = load("res://Player.tscn")
	var player = PlayerScene.instantiate()

	player.character_direction = Vector2.DOWN
	assert_eq(player.Get_animation_direction(), "down")

	player.character_direction = Vector2.UP
	assert_eq(player.Get_animation_direction(), "up")

	player.character_direction = Vector2.LEFT
	assert_eq(player.Get_animation_direction(), "side")
