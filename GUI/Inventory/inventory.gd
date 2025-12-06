class_name Inventory extends Resource

@export var inventory_slots : Array[ Inventory_Slot ]


func Add_item( new_item_data : Item ) -> bool:
	for i in inventory_slots.size():
		if inventory_slots[i] == null:
			var new_slot = Inventory_Slot.new()
			new_slot.item_data = new_item_data
			inventory_slots[i] = new_slot
			return true
	
	print("Инвентарь полный")
	return false

func Delete_item( used_item_data : Item ) -> void:
	for i in inventory_slots.size():
		if inventory_slots[i] != null:
			if inventory_slots[i].item_data == used_item_data:
				inventory_slots[i] = null
				return


func Group_items_to_save() -> Array:
	var items_to_save : Array = []
	for i in inventory_slots.size():
		items_to_save.append( Save_item( inventory_slots[i] ))
	return items_to_save


func Save_item( current_slot : Inventory_Slot ) -> String:
	var saved_item : String = ""
	if current_slot != null && current_slot.item_data != null:
		saved_item = current_slot.item_data.resource_path
	return saved_item


func Ungroup_items_to_load( items_to_load : Array ) -> void:
	for i in items_to_load.size():
		inventory_slots[i] = Load_item( items_to_load[i] )


func Load_item( loaded_item : String ) -> Inventory_Slot:
	if loaded_item == "":
		return null
	
	var new_slot = Inventory_Slot.new()
	new_slot.item_data = load( loaded_item )
	return new_slot
