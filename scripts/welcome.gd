extends Sprite3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.home.connect(_do_show)
	SignalManager.play.connect(_do_hide)
	SignalManager.about.connect(_do_hide)
	_do_show()

func _on_play_pressed() -> void:
	SignalManager.play.emit()

func _on_about_pressed() -> void:
	SignalManager.about.emit()
	
func _on_instructions_pressed() -> void:
	SignalManager.instructions.emit()

func _do_hide() -> void:
	hide()
	get_children()[0].hide()
	
func _do_show() -> void:
	show()
	get_children()[0].show();
