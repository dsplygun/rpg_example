extends StaticBody2D
class_name WorldMapObjectAnimated

var components : Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready():
	components = get_children()
	self.play("default")


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
	pass
