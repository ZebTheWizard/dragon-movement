extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.level_start.connect(_level_start)
	SignalManager.home.connect(queue_free)


func _level_start():
	var coord = Data.GetNextCoordinate()
	position.x = coord.x * Data.TileSize
	position.y = coord.y * Data.TileSize * -1
	
func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if (event is InputEventMouseButton):
		if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
			print("clicked goal")

func _on_area_entered(area: Area3D) -> void:
	if area is Dragon:
		Data.Score += 1
		Data.Level += 1
		SignalManager.level_start.emit()
