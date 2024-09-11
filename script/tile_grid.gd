extends Node3D

#signal tile_chosen(tile:Tile);
#signal tile_focused(tile:Tile);
signal matched_three_x;
signal matched_three_o;
signal no_empty_tiles_left;

const possible_match_threes:Array = [
	[0, 1, 2],
	[3, 4, 5],
	[6, 7, 8],
	[0, 3, 6],
	[1, 4, 7],
	[2, 5, 8],
	[0, 4, 8],
	[6, 4, 2],
];

@onready var children = get_children();

func _ready():
	connect_tile_signals_to_grid();
	reset_tile_grid();
	children[0].focus();
	pass;

func reset_tile_grid():
	reset_all_tiles();

	pass;

func reset_all_tiles():
	for child in children:
		child.building_type = Constants.TileMarkers.EMPTY;
		child.blur();
	pass;

func _physics_process(delta):
	pass;

func get_focused_tile() -> Tile:
	var tile:Tile = children[0];

	for child in children:
		if child.isFocused:
			tile = child;
	
	return tile;
	pass;

func unfocus_all_tiles():
	for tile in children:
		tile.blur();
	pass;

func check_if_empty_tiles_exist() -> bool:
	var count_empty_tiles:int = 0;

	for child in children:
		if child.building_type == Constants.TileMarkers.EMPTY:
			count_empty_tiles += 1;

	if count_empty_tiles < 1:
		no_empty_tiles_left.emit();
		return false;
	else:
		return true;
	pass;

func check_if_matched_three() -> bool:
	var found_match = false;

	# need to draw a strike "through" the match
	# from the first Tile to last

	for combination in possible_match_threes:
		var x = Constants.TileMarkers.X;

		if (
			x == children[combination[0]].building_type
			and x == children[combination[1]].building_type
			and x == children[combination[2]].building_type
		):
			found_match = true;
			matched_three_x.emit();
			
		var o = Constants.TileMarkers.O;

		if (
			o == children[combination[0]].building_type
			and o == children[combination[1]].building_type
			and o == children[combination[2]].building_type
		):
			found_match = true;
			matched_three_o.emit();

	return found_match;
	pass;

func _on_focused_tile_was_chosen(tile:Tile):
	var found_match = check_if_matched_three();
	var empty_tiles_exist = check_if_empty_tiles_exist();
		
	pass;

func connect_tile_signals_to_grid():
	for child in children:
		child.focused_tile_was_chosen.connect(
			_on_focused_tile_was_chosen.bind(child)
		)
	pass;

func move_down_one_tile():
	var index = get_focused_tile().get_index();
	var target_index:int = index + 3;
#
	if target_index > children.size() - 1:
		return;

	unfocus_all_tiles();
	children[target_index].focus();
	pass;

func move_right_one_tile():
	var index = get_focused_tile().get_index();
	var target_index:int = index + 1;

	if target_index > children.size() - 1:
		return;

	unfocus_all_tiles();
	children[target_index].focus();
	pass;

func move_left_one_tile():
	var index = get_focused_tile().get_index();
	var target_index:int = index - 1;

	if target_index < 0:
		return;

	unfocus_all_tiles();
	children[target_index].focus();
	pass;

func move_up_one_tile():
	var index = get_focused_tile().get_index();
	var target_index:int = index - 3;
#
	if target_index < 0:
		return;
#
	unfocus_all_tiles();
	children[target_index].focus();
	pass;
