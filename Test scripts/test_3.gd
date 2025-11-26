extends GutTest

func test_state_dead():
	
	var PlayerScene = load("res://Player.tscn")
	var player = PlayerScene.instantiate()
	player._ready()
	var state = State_Dead.new()
	state.player = player
	player.direction = Vector2.UP
	
	state.Enter()
	assert_eq(player.velocity, Vector2.UP * -state.knock_back_speed)
	assert_true(player.current_sprite.visible)
	
	state.timer = 0.0
	state.Process(0.1)
	assert_eq(player.velocity, Vector2.ZERO)
