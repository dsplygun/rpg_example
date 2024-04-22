extends Node2D
var grid : AStarGrid2D
var enemy_positions: Dictionary
var finished = false

@export var bg_music : AudioStream = null
# Called when the node enters the scene tree for the first time.
func _ready():
	grid = AStarGrid2D.new()
	grid.region = Rect2i(6,4,16,7)
	grid.cell_size = Vector2i(16,16)
	grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_OCTILE
	grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_OCTILE
	grid.jumping_enabled = true
	grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	grid.update()
	enemy_positions = {}
	for child in get_children():
		if child.has_method("register_grid"):
			child.register_grid(grid)
		if child.is_in_group("Enemy") and child.get("grid_position"):
			enemy_positions[child.name] = child.grid_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if len(enemy_positions) == 0 and not finished:
		$Timer.start()
		finished = true

func _input(event):
	if event is InputEventMouseMotion:
		var mouse_pos := get_global_mouse_position() / 2
		var mouse_grid := Vector2( int(mouse_pos.x/grid.cell_size.x), int(mouse_pos.y/grid.cell_size.y) )
		if grid.region.has_point(mouse_grid):
			$TileMap/SelectionRect.visible = true
			$TileMap/SelectionRect.position = mouse_grid*grid.cell_size
			if Vector2i(mouse_grid) in enemy_positions.values():
				$TileMap/SelectionRect.modulate = Color(255,0,0)
			else:
				$TileMap/SelectionRect.modulate = Color(255,255,0)
				
		else:
			$TileMap/SelectionRect.visible = false
			


func _on_timer_timeout():
	Info.return_scene()
