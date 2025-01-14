extends Area3D


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if (event is InputEventMouseButton):
		if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
			Data.Speed = (Data.Speed + 1) % len(Data.Speeds)
			SignalManager.change_speed.emit(Data.Speed)