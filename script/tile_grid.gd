extends Node3D

signal focused_tile_chosen;

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

	pass;

func reset_tile_grid():
	for child in children:
		child.building_type = Constants.TileMarkers.EMPTY;
		child.blur();

	children[0].focus();
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

func do_empty_tiles_exist() -> bool:
	var count_empty_tiles:int = 0;

	for child in children:
		if child.building_type == Constants.TileMarkers.EMPTY:
			count_empty_tiles += 1;

	if count_empty_tiles < 1:
		return false;
	else:
		return true;
	pass;

func found_match_three_x() -> bool:
	var found_match:bool = false;

	for combination in possible_match_threes:
		var x = Constants.TileMarkers.X;

		if (
			x == children[combination[0]].building_type
			and x == children[combination[1]].building_type
			and x == children[combination[2]].building_type
		):
			found_match = true;

	return found_match;
	pass;

func _on_focused_tile_was_chosen(tile:Tile):
	focused_tile_chosen.emit();

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

func is_center_tile_open():
	return children[4].building_type == Constants.TileMarkers.EMPTY
	pass;

func found_match_three_o() -> bool:
	var found_match:bool = false;

	for combination in possible_match_threes:
		var o = Constants.TileMarkers.O;

		if (
			o == children[combination[0]].building_type
			and o == children[combination[1]].building_type
			and o == children[combination[2]].building_type
		):
			found_match = true;

	return found_match;
	pass;

func find_a_winning_move_for_o():
	for combination in possible_match_threes:
		var o = Constants.TileMarkers.O;
		var found_match:bool = false;

		# check all combinations for matches...
		# 0 and 1, 0 and 2, 1 and 2

		if (
			o == children[combination[0]].building_type
			and o == children[combination[1]].building_type
			and children[combination[2]].building_type == Constants.TileMarkers.EMPTY
		):
			return children[combination[2]];

		if (
			o == children[combination[0]].building_type
			and o == children[combination[2]].building_type
			and children[combination[1]].building_type == Constants.TileMarkers.EMPTY
		):
			return children[combination[1]];
		
		if (
			o == children[combination[1]].building_type
			and o == children[combination[2]].building_type
			and children[combination[0]].building_type == Constants.TileMarkers.EMPTY
		):
			return children[combination[0]];

	return false;
	pass;

func choose_random_open_tile_for_ai():
	var open_tiles:Array[Tile] = [];

	for child in children:
		if child.building_type == Constants.TileMarkers.EMPTY:
			open_tiles.append(child);

	if open_tiles.size() > 0:
		var chosen_tile = open_tiles[randi() % open_tiles.size()]
		chosen_tile.choose(Constants.TileMarkers.O)

	pass;

func hide_focus_indicator():
	for child in children:
		child.hide_focus_indicator();
	pass;

func show_focus_indicator():
	get_focused_tile().show_focus_indicator();
	pass;
