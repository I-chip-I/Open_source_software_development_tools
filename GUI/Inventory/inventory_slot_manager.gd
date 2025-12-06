class_name Inventory_Slot_Manager extends Button

@onready var texturerect_slot : TextureRect = $TextureRect_slot
@onready var texturerect_selected_slot : TextureRect = $TextureRect_selected_slot
@onready var texturerect_selected_item : TextureRect = $TextureRect_item
@onready var label_item_description : Label = $Label_item_description

var inventory_slot : Inventory_Slot : set = Set_slot
var slot_was_selected : bool = false


func _ready()-> void:
	texturerect_selected_item.texture = null
	label_item_description.text = ""
	
	focus_entered.connect( In_focus )
	focus_exited.connect( Out_of_focus )
	
	pressed.connect( Choose_item )


func Set_slot( new_inventary_slot : Inventory_Slot ) -> void:
	inventory_slot = new_inventary_slot
	
	if inventory_slot == null:
		return
	
	texturerect_selected_item.texture = inventory_slot.item_data.item_texture


func In_focus(  ) -> void:
	if inventory_slot != null && inventory_slot.item_data != null:
		Inventory_Menu.Update_item_description( inventory_slot.item_data.item_description )
	else:
		Inventory_Menu.Update_item_description( "There is no item in this cell." )
	
	slot_was_selected = true
	Update_icon( slot_was_selected )


func Out_of_focus(  ) -> void:
	Inventory_Menu.Update_item_description( "There is no item in this cell." )
	
	slot_was_selected = false
	Update_icon( slot_was_selected )


func Update_icon( item_description : bool ) -> void:
	if item_description == true:
		texturerect_slot.visible = false
		texturerect_selected_slot.visible = true
	else:
		texturerect_selected_slot.visible = false
		texturerect_slot.visible = true

func Choose_item() -> void:
	if inventory_slot != null && inventory_slot.item_data != null:
		var item_was_used = inventory_slot.item_data.Use_item_for()
		
		if item_was_used == false:
			return
		
		print ("Что-то сработало")
		Inventory_Menu.inventory.Delete_item( inventory_slot.item_data )
		Inventory_Menu.Hide_Inventory()
