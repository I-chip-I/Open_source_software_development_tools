extends CanvasLayer

@onready var save_button : Button = $VBoxContainer/Button_Save
@onready var load_button : Button = $VBoxContainer/Button_Load

var game_is_paused : bool = false

func _ready() -> void:
	save_button.pressed.connect( Button_save_was_pressed )
	load_button.pressed.connect( Button_load_was_pressed )
	Hide_Pause_menu()

func Show_Pause_menu() -> void:
	get_tree().paused = true
	visible = true
	game_is_paused = true
	save_button.grab_focus()

func Hide_Pause_menu() -> void:
	get_tree().paused = false
	visible = false
	game_is_paused = false

func _unhandled_input( some_button_pressed : InputEvent ) -> void:
	if some_button_pressed.is_action_pressed( "Pause" ):
		if game_is_paused == false:
			Show_Pause_menu()
		else:
			Hide_Pause_menu()
	
	get_viewport().set_input_as_handled()

func Button_save_was_pressed() -> void:
	if game_is_paused == false:
		return
	
	Save_Manager.Save_game()
	Hide_Pause_menu()

func Button_load_was_pressed() -> void:
	if game_is_paused == false:
		return
	
	Save_Manager.Load_game()
	Hide_Pause_menu()
