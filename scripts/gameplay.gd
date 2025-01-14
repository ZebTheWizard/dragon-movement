extends Sprite3D

@export var origin: Node3D;
@export var scoreLabel: Label
@export var levelLabel: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_do_hide()
	SignalManager.home.connect(_do_hide)
	SignalManager.play.connect(_play)
	SignalManager.level_start.connect(_level_start)
	if Data.ShouldSkipHomeScreen:
		SignalManager.play.emit()

func _play():
	_do_show()
	Data.Level = 0
	Data.Score = 0
	Data.Speed = 0
	PrefabManager.Spawn(origin, "Dragon")
	PrefabManager.Spawn(origin, "Goal")
	SignalManager.level_start.emit();

func _level_start():
	print("new level")
	Data.Speed = 0
	Data.ShuffleCoordinates()
	Data.PrepareLookupTables()
	SignalManager.level_destroy.emit()
	scoreLabel.text = "Score:\n" + str(Data.Score)
	levelLabel.text = "Level:\n" + str(Data.Level + 1)
	for i in range(10):
		PrefabManager.Spawn(origin, "Stop")
		
	
func _do_hide() -> void:
	hide()
	get_children()[0].hide()
	
func _do_show() -> void:
	show()
	get_children()[0].show();
