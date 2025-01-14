extends Node

var Score:int = 42
var CoordinatePool: Array = []
var PoolIndex: int = 0;
var TileSize: float = 0.85
var xTable: Array = []
var yTable: Array = []
var Level: int = 5
var Speeds: Array = []
var Speed = 0
var ShouldSkipHomeScreen = false

func _ready() -> void:
	Speeds = [0, 0.5]
	
func ShuffleCoordinates():
	seed(("Godot Rocks!" + str(Level)).hash())
	PoolIndex = 0
	CoordinatePool.resize(64)
	for i in range(8):
		for j in range(8):
			CoordinatePool[j * 8 + i] = Vector2(i,j)
	
	CoordinatePool.shuffle();
	
func PrepareLookupTables():
	xTable.resize(8)
	yTable.resize(8)
	for i in range(8):
		xTable[i] = []
		yTable[i] = []
		for j in range(8):
			xTable[i].append(null)
			yTable[i].append(null)

func GetNextCoordinate() -> Vector2:
	var coord = CoordinatePool[PoolIndex]
	PoolIndex = (PoolIndex + 1) % len(CoordinatePool)
	return coord
	
func FindNextMovesFor(coord: Vector2) -> Array:
	var moves = [0, 0, 0, 0]
	
	var verticals = xTable[coord.x]
	var horizontals = yTable[coord.y]
	var verticalSearchSpace = len(verticals)
	var horizontalSearchSpace = len(horizontals)
	var cursor_up = coord.y
	var cursor_down = coord.y
	var cursor_left = coord.x
	var cursor_right = coord.x
	
	while cursor_down >= 0 or cursor_up < verticalSearchSpace:
		cursor_down -= 1
		cursor_up += 1
		if cursor_down >= 0:
			var temp = verticals[cursor_down]
			if temp != null:
				temp.y += 1
				cursor_down = -1
				moves[0] = null
				if not coord.is_equal_approx(temp):
					moves[0] = temp
		if cursor_up < verticalSearchSpace:
			var temp = verticals[cursor_up]
			if temp != null:
				temp.y -= 1
				cursor_up = verticalSearchSpace
				moves[1] = null
				if not coord.is_equal_approx(temp):
					moves[1] = temp
	while cursor_left >= 0 or cursor_right < horizontalSearchSpace:
		cursor_left -= 1
		cursor_right += 1
		if cursor_left >= 0:
			var temp = horizontals[cursor_left]
			if temp != null:
				temp.x += 1
				cursor_left = -1
				moves[2] = null
				if not coord.is_equal_approx(temp):
					moves[2] = temp
		if cursor_right < horizontalSearchSpace:
			var temp = horizontals[cursor_right]
			if temp != null:
				temp.x -= 1
				cursor_right = horizontalSearchSpace
				moves[3] = null
				if not coord.is_equal_approx(temp):
					moves[3] = temp
	
	if moves[0] is int:
		moves[0] = null
		if cursor_down < 0:
			var temp = Vector2(coord.x, 0)	
			if not coord.is_equal_approx(temp):
				moves[0] = temp
	if moves[1] is int:
		moves[1] = null
		if cursor_up >= verticalSearchSpace:
			var temp = Vector2(coord.x, verticalSearchSpace - 1)
			if not coord.is_equal_approx(temp):
				moves[1] = temp
	if moves[2] is int:
		moves[2] = null
		if cursor_left < 0:
			var temp = Vector2(0, coord.y)
			if not coord.is_equal_approx(temp):
				moves[2] = temp
	if moves[3] is int:
		moves[3] = null
		if cursor_right >= horizontalSearchSpace:
			var temp = Vector2(horizontalSearchSpace - 1, coord.y)
			if not coord.is_equal_approx(temp):
				moves[3] = temp

	return moves
	
