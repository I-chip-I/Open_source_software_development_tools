extends CanvasLayer

const INVENTORY_SLOT_BUTTON_SCENE = preload("res://GUI/Inventory/inventory_slot_button.tscn")

@onready var item_description : Label = $ItemDescription

@export var inventory : Inventory

var inventory_is_opened : bool = false

func _ready() -> void:
	Clear_inventory()
	Hide_Inventory()

func Show_Inventory() -> void:
	visible = true
	inventory_is_opened = true
	Update_inventory()

func Hide_Inventory() -> void:
	visible = false
	inventory_is_opened = false
	Clear_inventory()

func _unhandled_input( E_button_pressed : InputEvent ) -> void:
	if E_button_pressed.is_action_pressed( "Inventory" ):
		if get_tree().paused:
			return
		
		if inventory_is_opened == false:
			Show_Inventory()
		else:
			Hide_Inventory()


func Clear_inventory() -> void:
	for i in $PanelContainer/GridContainer.get_children():
		i.queue_free()

func Update_inventory() -> void:
	for i in inventory.inventory_slots:
		var new_slot = INVENTORY_SLOT_BUTTON_SCENE.instantiate()
		$PanelContainer/GridContainer.add_child( new_slot )
		new_slot.inventory_slot = i
	
	$PanelContainer/GridContainer.get_child( 0 ).grab_focus()

func Update_item_description( new_text : String ) -> void:
	item_description.text = new_text
