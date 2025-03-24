class_name Interactable extends RigidBody3D

var prompt: String;

func _init():
	prompt = "Press E to interact"

# Overridable
func on_interact(player: Player) -> void:
	pass
