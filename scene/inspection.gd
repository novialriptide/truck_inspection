extends Node

@export var illegal_items: Array[PackedScene];
@export var truck: PackedScene;
@export var truck_position: Vector3 = Vector3(0, 50, 0)

@onready var player: Player = $Player

func on_submit_items() -> void:
	var non_illegal_items_found = 0
	
	for item in player.inventory:
		if item not in illegal_items:
			non_illegal_items_found += 1

func _ready() -> void:
	var truck_instance = truck.instantiate()
	add_child(truck_instance)
	truck_instance.position = truck_position
