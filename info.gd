extends Node

var loaded_scenes : Array = []
var main = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_current_scene_as_main():
	loaded_scenes.append(get_tree().current_scene)
	main = len(loaded_scenes)-1

func change_scene_to_file(path : String, params : Dictionary = {}):
	var new_scene : PackedScene = load(path)
	get_tree().root.remove_child(get_tree().current_scene)
	var scene_instance := new_scene.instantiate()
	if scene_instance.has_method("load_parameters"):
		scene_instance.load_parameters(params)
	get_tree().root.add_child(scene_instance)
	get_tree().current_scene = scene_instance

func change_scene_to_packed(scene : PackedScene, params : Dictionary = {}):
	get_tree().root.remove_child(get_tree().current_scene)
	var scene_instance := scene.instantiate()
	if scene_instance.has_method("load_parameters"):
		scene_instance.load_parameters(params)
	get_tree().root.add_child(scene_instance)
	get_tree().current_scene = scene_instance
	
	
func return_scene():
	var temp_scene : Node = get_tree().current_scene
	get_tree().root.remove_child(get_tree().current_scene)
	temp_scene.queue_free()
	get_tree().root.add_child(loaded_scenes[main])
	get_tree().current_scene = loaded_scenes[main]
	if get_tree().current_scene.has_method("on_reload"):
		get_tree().current_scene.on_reload()
