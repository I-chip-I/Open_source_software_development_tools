extends GutTest

func test_enemy_set_direction():
	var enemy = Enemy.new()
	enemy.character_direction =  Vector2.UP
	
	enemy.Set_direction(Vector2.LEFT)
	assert_eq(enemy.character_direction, Vector2.LEFT)
