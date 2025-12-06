class_name Item extends Resource

@export var item_name : String
@export_multiline var item_description : String
@export var item_texture : Texture2D

@export_category("Use of the item")
@export var variants_of_use : Array[ Item_Use ]

func Use_item_for() -> bool:
	if variants_of_use.size() == 0:
		print("бесполезный")
		return false
	
	for i in variants_of_use:
		i.Use_item_for()
	
	return true
