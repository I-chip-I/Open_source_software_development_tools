extends GutTest

func test_enemy_update_sprite():
	var enemy = Enemy.new()
	enemy.sprite_enemy_standing_down = Sprite2D.new()
	enemy.sprite_enemy_standing_up = Sprite2D.new()
	enemy.sprite_enemy_walking_down = Sprite2D.new()
	
	enemy.current_sprite = enemy.sprite_enemy_standing_up
	enemy.character_direction = Vector2.DOWN
	enemy.Update_sprite("standing")
	
	assert_eq(enemy.current_sprite, enemy.sprite_enemy_walking_down)
