extends Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.target_destroy.connect(_target_destroy)
	
func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if (event is InputEventMouseButton):
		if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
			var coord = Vector2(position.x, position.y * -1) / Data.TileSize
			SignalManager.move_to.emit(coord.round())

func _target_destroy():
	queue_free()
