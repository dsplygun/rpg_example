extends CharacterBody2D

var grid : AStarGrid2D
var grid_position := Vector2i(6,4)
var current_path : Array[Vector2i]
var grid_offset := Vector2(8,8)
var move_tween : Tween = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos := get_global_mouse_position() / 2
		var to_position := Vector2( int(mouse_pos.x/grid.cell_size.x), int(mouse_pos.y/grid.cell_size.y) )
		if Vector2i(to_position) not in $"..".enemy_positions.values():
			walk_to(to_position)
		else:
			var found_enemy = $"..".enemy_positions.find_key(Vector2i(to_position))
			attack( get_node("../"+found_enemy ) )
		
func register_grid(new_grid : AStarGrid2D):
	grid = new_grid
	grid_offset = grid.cell_size/2
	grid_position = Vector2i(position/grid.cell_size)
	position = Vector2(grid_position)*grid.cell_size+grid_offset

func walk_to(new_position : Vector2i):
	current_path = grid.get_id_path( grid_position, new_position )
	if not move_tween or not move_tween.is_valid():
		move_tween = create_tween()
	for p in current_path:
		var distance : float = (p-grid_position).length()
		move_tween.tween_property(self,"position",Vector2(p)*grid.cell_size+grid_offset,distance/4)
		grid_position = p

func attack(target : EnemyCombat, damage : int = 20):
	target.take_damage()
