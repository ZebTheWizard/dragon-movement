class_name Dragon extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.home.connect(queue_free)
	SignalManager.level_start.connect(_on_level_start)
	SignalManager.move_to.connect(_move_to)
	
func _on_level_start() -> void:
	_move_to(Data.GetNextCoordinate())
	
func _move_to(coord: Vector2):
	var newPosition = Vector3(0,0, position.z)
	newPosition.x = coord.x * Data.TileSize
	newPosition.y = coord.y * Data.TileSize * -1
	var tween: Tween = AnimationManager.Animate()
	var duration = Data.Speeds[Data.Speed]
	tween.tween_property(self, "position",newPosition, duration)
	
	SignalManager.target_destroy.emit()
	var afterTween = func ():
		Data.Speed = 1
		call_deferred("_draw_moves", coord)
	
	tween.tween_callback(afterTween)

func _draw_moves(current_coord: Vector2):
	var moves = Data.FindNextMovesFor(current_coord)
	for coord in moves:
		if coord != null:
			var target = PrefabManager.Spawn(get_parent(), "Target")
			if target:
				target.position.x = coord.x * Data.TileSize
				target.position.y = coord.y * Data.TileSize * -1

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if (event is InputEventMouseButton):
		if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
			print("clicked dragon")
			#var tween: Tween = AnimationManager.Animate()
			#tween.tween_property(self, "position", Vector3(0, 0, position.z), 1)
