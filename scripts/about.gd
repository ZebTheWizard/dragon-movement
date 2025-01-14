extends Sprite3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.home.connect(_do_hide)
	SignalManager.about.connect(_do_show)
	_do_hide()

func _on_play_pressed() -> void:
	SignalManager.home.emit()

func _do_hide() -> void:
	hide()
	get_children()[0].hide()
	
func _do_show() -> void:
	show()
	get_children()[0].show();
