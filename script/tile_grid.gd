extends Node3D

signal game_is_won (winner: Constants.TileStates);
signal no_moves_remain;

const winning_combinations:Array = [
	[0, 1, 2],
	[3, 4, 5],
	[6, 7, 8],
	[0, 3, 6],
	[1, 4, 7],
	[2, 5, 8],
	[0, 4, 8],
	[6, 4, 2],
]

@onready var children = get_children();

var isPlayerTurn:bool = true;
var isPlaying:bool = true; # toggle off after win?

func _ready():
	connect_tile_signals_to_grid();
	focus_tile_at_index(0);
	get_focused_tile();
		
	pass;

func _unhandled_input(event):
	#if !isPlayerTurn:
		#return;
	if event.is_action("move_right") and not event.is_echo():
		if event.is_pressed():
			handle_move("move_right");
	if event.is_action("move_left") and not event.is_echo():
		if event.is_pressed():
			handle_move("move_left");
	if event.is_action("move_down") and not event.is_echo():
		if event.is_pressed():
			handle_move("move_down");
	if event.is_action("move_up") and not event.is_echo():
		if event.is_pressed():
			handle_move("move_up");
	pass;

func _physics_process(delta):
	pass;

func handle_move(dir: String):
	var focused_index = get_focused_tile().get_index();

	match dir:
		"move_right":
			handle_move_right(focused_index);
		"move_left":
			handle_move_left(focused_index);
		"move_down":
			handle_move_down(focused_index);
		"move_up":
			handle_move_up(focused_index);
	pass;

func handle_move_right(index:int):
	var target_index:int = index + 1;

	if target_index > children.size() - 1:
		return;

	focus_tile_at_index(target_index);
	pass;
	
func handle_move_left(index:int):
	var target_index:int = index - 1;

	if target_index < 0:
		return;
#
	focus_tile_at_index(target_index);
	pass;

func handle_move_up(index:int):
	var target_index:int = index - 3;

	if target_index < 0:
		return;

	focus_tile_at_index(target_index);
	pass;

func handle_move_down(index:int):
	var target_index:int = index + 3;

	if target_index > children.size() - 1:
		return;

	focus_tile_at_index(target_index);
	pass;

func unfocus_all_tiles():
	for tile in children:
		tile.blur();
	pass;

func focus_tile_at_index(index:int):
	var tile = get_child(index);

	unfocus_all_tiles();
	tile.focus();

	pass;

func get_focused_tile():
	var tile:Tile;

	for child in children:
		if child.get_selected_state():
			tile = child;
		pass;

	return tile;
	pass;

func _on_tile_was_clicked(tile:Tile):
	var current_marker = get_current_turn_marker();

	tile.set_building_type(current_marker);
	
	if check_win_conditions_for(current_marker):
		game_is_won.emit(current_marker);
	else:
		isPlayerTurn = !isPlayerTurn;
	pass;

func check_win_conditions_for(state:Constants.TileStates) -> bool:
	var found_match = false;

	for combination in winning_combinations:
		if (
			state == children[combination[0]].building_type
			and state == children[combination[1]].building_type
			and state == children[combination[2]].building_type
		):
			found_match = true;
	
	return found_match;
	pass;

func connect_tile_signals_to_grid():
	for child in children:
		child.focused_tile_was_clicked.connect(
			_on_tile_was_clicked.bind(child)
		)
	pass;

func get_current_turn_marker() -> Constants.TileStates:
	if isPlayerTurn:
		return Constants.TileStates.X
	else:
		return Constants.TileStates.O
	pass;
