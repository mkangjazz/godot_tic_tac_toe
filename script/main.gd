class_name Game
extends Node3D

# DEBUG
@onready var debug_label = %DebugLabel;
@onready var whose_turn = %WhoseTurn
@onready var reset_button = %Continue;
@onready var scores_label = %Scores

# 
@onready var controllers_container = %ControllersContainer
@onready var tile_grid = %TileGrid;

var player_manager:PlayerManager;
var isGamePaused = true;

func _ready():
	set_up_initial_game();

	pass;

func _process(_delta):
	if !isGamePaused:
		whose_turn.text = "Turn: " + str(player_manager.active_player.marker);
		scores_label.text = "P1: " + str(player_manager.players.p1.score) + " | " + "P2: " + str(player_manager.players.p2.score)
	pass;

func _unhandled_input(event):
	if !isGamePaused:
		if player_manager.active_player.type == Constants.PlayerTypes.PLAYER:
			if event.is_action("move_right") and not event.is_echo():
				if event.is_pressed():
					handle_move_right();
			if event.is_action("move_left") and not event.is_echo():
				if event.is_pressed():
					handle_move_left();
			if event.is_action("move_down") and not event.is_echo():
				if event.is_pressed():
					handle_move_down();
			if event.is_action("move_up") and not event.is_echo():
				if event.is_pressed():
					handle_move_up();
			if event.is_action("confirm") and not event.is_echo():
				if event.is_pressed():
					handle_confirm();
	pass;

func set_up_initial_game():
	set_up_managers();
	player_manager.set_to_singleplayer();
	player_manager.AI_turn_to_move.connect(_on_AI_turn_to_move);
	isGamePaused = false;
	pass;

func set_up_managers():
	player_manager = PlayerManager.new();
	controllers_container.add_child(player_manager);
	
	print("managers: ", controllers_container.get_children())
	pass;

func handle_move_up():
	tile_grid.move_up_one_tile();
	pass;

func handle_move_right():
	tile_grid.move_right_one_tile();
	pass;

func handle_move_down():
	tile_grid.move_down_one_tile();
	pass;

func handle_move_left():
	tile_grid.move_left_one_tile();
	pass;

func handle_confirm():
	var focused_tile = tile_grid.get_focused_tile();

	if focused_tile.building_type == Constants.TileMarkers.EMPTY:
		focused_tile.choose(
			player_manager.active_player.marker
		);
	pass;

func _on_tile_grid_focused_tile_chosen():
	print("_on_tile_grid_focused_tile_chosen")

	if tile_grid.found_match_three_x():
		player_manager.players.p1.score += 1;
		show_win();
		return;

	if tile_grid.found_match_three_o():
		player_manager.players.p2.score += 1;
		show_win();
		return;

	if !tile_grid.do_empty_tiles_exist():
		show_tie();
		return;

	player_manager.switch_active_player();

	if player_manager.active_player.type == Constants.PlayerTypes.PLAYER:
		tile_grid.show_focus_indicator();
		pass;

	pass

func set_up_next_round():
	tile_grid.reset_tile_grid();

	# hack to unfocus the continue button
	reset_button.hide();
	reset_button.show();

	# hmm
	player_manager.who_moves_first_next_round = player_manager.get_the_other_player(
		player_manager.who_moved_first_this_round
	)
	player_manager.active_player = player_manager.who_moves_first_next_round;
	player_manager.who_moved_first_this_round = player_manager.who_moves_first_next_round;

	isGamePaused = false;
	pass;

func show_win():
	isGamePaused = true;
	tile_grid.hide_focus_indicator();

	var active_player = get_key(
		Constants.TileMarkers,
		player_manager.active_player.marker
	);

	print("show_win: ", active_player);
	debug_label.text = active_player + " wins!";

	# show score
	# show continue button
	# show quit button ? 
	pass;

func show_tie():
	isGamePaused = true;
	tile_grid.hide_focus_indicator();
	
	debug_label.text = "Cat's Game";
	# show score
	# show continue button
	# show quit button ?

	pass;

func get_key(dictionary, index):
	return dictionary.keys()[index]

func _on_AI_turn_to_move():
	tile_grid.hide_focus_indicator();

	if !isGamePaused:
		if tile_grid.is_center_tile_open():
			tile_grid.children[4].choose(Constants.TileMarkers.O);
			return;

		if tile_grid.find_a_winning_move_for_o():
			var tile = tile_grid.find_a_winning_move_for_o();

			tile.choose(Constants.TileMarkers.O);
			return;

		# if no better move, move random
		tile_grid.choose_random_open_tile_for_ai();

	pass;

func _on_continue_pressed():
	set_up_next_round();

	pass
