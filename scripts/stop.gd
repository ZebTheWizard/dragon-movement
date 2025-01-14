extends Sprite3D

signal clone_created


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.level_destroy.connect(_level_destroy)
	clone_created.connect(_on_clone)

func _level_destroy() -> void:
	queue_free()

func _on_clone() -> void:
	var coord = Data.GetNextCoordinate();
	position.x = coord.x * Data.TileSize
	position.y = coord.y * Data.TileSize * -1
	Data.xTable[coord.x][coord.y] = coord
	Data.yTable[coord.y][coord.x] = coord
