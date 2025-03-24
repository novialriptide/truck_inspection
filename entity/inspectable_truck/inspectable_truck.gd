class_name InspectableTruck extends Node

@export var license_plate: String;
@export var manifest: Manifest;
@export var potential_items: Array[PackedScene];

var radius = 40;
var item_count = 1000;

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
	item_instance.position = Vector3(
		randf_range(-radius, radius),
		randf_range(0.0, 0.0),
		randf_range(-radius, radius)
	)

	return item_instance

func _ready() -> void:
	license_plate = IdentificationGenerators.new_license_plate()
	manifest = Manifest.new()
	for i in range(item_count):
		spawn_random_item()
