class_name PickableItem extends Interactable

func _init():
	prompt = "Press E to pick up"

func on_interact(player: Player):
	player.inventory.append(self)
	queue_free()
