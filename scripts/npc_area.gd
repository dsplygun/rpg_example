extends InteractableArea2D
class_name NPCArea2D
@export var character_name : String
@export var dialogue_list : Array[DialogicTimeline]
@export var exhausted_dialogue_list : Array[DialogicTimeline]
@export var scene_to_load : PackedScene
var current_dialogue = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	tooltip += " " + character_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func interact() -> bool:
	if scene_to_load:
		Info.change_scene_to_packed(scene_to_load)
		if $"..".is_in_group("To be deleted"):
			$"..".queue_free()
	elif current_dialogue < len(dialogue_list):
		Dialogic.start(dialogue_list[current_dialogue])
		current_dialogue += 1
	elif len(exhausted_dialogue_list) > 0:
		Dialogic.start(exhausted_dialogue_list.pick_random())
	elif len(dialogue_list) > 0:
		Dialogic.start(dialogue_list[-1])
	else:
		pass
	return true
