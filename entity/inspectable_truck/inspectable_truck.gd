class_name InspectableTruck extends Node

@export var license_plate: String;
@export var manifest: Manifest;
@export var potential_items: Array[PackedScene];

func spawn_random_item() -> PickableItem:
	if potential_items.is_empty():
		push_error("potential_items is empty.")
		return null

	var random_item_scene = potential_items.pick_random()
	var item_instance = random_item_scene.instantiate()
	if !(item_instance is PickableItem):
		push_error("Spawned item is not a PickableItem! Scene: ", item_instance.resource_path)
		item_instance.queue_free()
		return null

	add_child(item_instance)
	return item_instance

func _ready() -> void:
	license_plate = IdentificationGenerators.new_license_plate()
	manifest = Manifest.new()
	spawn_random_item()
