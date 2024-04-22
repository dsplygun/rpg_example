extends StaticBody2D
class_name WorldMapObject

var components : Array[Node]
@export var sprite : SpriteFrames 
@export var dialogue_list : Array[DialogicTimeline]
@export var exhausted_dialogue_list : Array[DialogicTimeline]
@export var scene_to_load : PackedScene
@export_range(0,10) var sprite_scale : float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	components = get_children()
	$AnimatedSprite2D.sprite_frames = sprite
	$AnimatedSprite2D.scale *= sprite_scale 
	$AnimatedSprite2D.play("default")
	$NPCArea2D.scene_to_load = scene_to_load
	$NPCArea2D.dialogue_list = dialogue_list
	$NPCArea2D.exhausted_dialogue_list = exhausted_dialogue_list


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func call_function(f_name : String) -> bool:
	for comp in components:
		if comp.has_method(f_name):
			if comp.call(f_name):
				return true
	return false

func get_property(p_name : String) -> Variant:
	for comp in components:
		if comp.get(p_name):
			return comp.get(p_name)
	return null
			
func set_property(p_name : String, value : Variant) -> bool:
	for comp in components:
		if comp.get(p_name):
			comp.set(p_name, value)
			return true
	return false

func interact():
	return call_function("interact")
	
