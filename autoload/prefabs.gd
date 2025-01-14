extends Node

var _prefabs:Dictionary = {}
var queue:Array = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_prefabs["Dragon"] = preload("res://prefabs/dragon.tscn")
	_prefabs["Stop"] = preload("res://prefabs/stop.tscn")
	_prefabs["Target"] = preload("res://prefabs/target.tscn")
	_prefabs["Goal"] = preload("res://prefabs/goal.tscn")

func Spawn(parent: Node, name:String) -> Node3D:
	if (_prefabs.has(name)):
		var prefab:PackedScene =  _prefabs.get(name)
		var node = prefab.instantiate()
		parent.add_child(node)
		if (node.has_signal('clone_created')):
			node.clone_created.emit()
		return node
	return null
