extends CharacterBody2D
class_name EnemyCombat

var grid : AStarGrid2D
var grid_position := Vector2i(6,4)
var current_path : Array[Vector2i]
var grid_offset := Vector2(8,8)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func register_grid(new_grid : AStarGrid2D):
	grid = new_grid
	grid_offset = grid.cell_size/2
	grid_position = Vector2i(position/grid.cell_size)
	position = Vector2(grid_position)*grid.cell_size+grid_offset

func take_damage(damage : int = 20):
	$"..".enemy_positions.erase(self.name)
	queue_free()
