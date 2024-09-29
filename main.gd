class_name Game
extends Node3D

@onready var reset_button = %Continue;
@onready var scores_label = %Scores

# 
@onready var controllers_container = %ControllersContainer
@onready var tile_grid = %TileGrid;
@onready var toggle_player_btn = %TogglePlayer;
@onready var toggle_player_switch = %CheckButton2;
@onready var toggle_wins_btn = %ToggleWins;
@onready var toggle_wins_switch = %CheckButton;
@onready var main_menu_scene = %MainMenu;
@onready var victory_label = %VictoryOrDefeat
@onready var x_score_label = %XScore;
@onready var o_score_label = %OScore;
@onready var continue_button = %Continue;
@onready var in_game_ui = %InGameUI
@onready var map = %map
@onready var scene_transitions = %SceneTransitions
@onready var camera_ap: AnimationPlayer = %CameraAP

var player_manager:PlayerManager;
var game_manager:GameManager;
var scene_is_transitioning: bool = false;

func _ready():
	set_up_managers();
	main_menu_scene.show();
	in_game_ui.hide();
	focus_player_switch();
	player_manager.AI_turn_to_move.connect(_on_AI_turn_to_move);
	pass;

func _process(_delta):
	if player_manager:
		if player_manager.players.p1 and player_manager.players.p2:
			x_score_label.text = game_manager.numerals[str(player_manager.players.p1.score)]
			o_score_label.text = game_manager.numerals[str(player_manager.players.p2.score)]
	pass;

func _unhandled_input(event):
	if scene_is_transitioning:
		return;
	
	if !game_manager.isGamePaused and !scene_is_transitioning:
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

func focus_player_switch():
	toggle_player_btn.grab_focus()
	pass;

func focus_continue_button():
	continue_button.grab_focus()
	pass;

func set_up_managers():
	player_manager = PlayerManager.new();
	controllers_container.add_child(player_manager);
	
	game_manager = GameManager.new()
	controllers_container.add_child(game_manager);

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

func _on_tile_grid_tile_clicked():
	if scene_is_transitioning:
		return;
	
	if !game_manager.isGamePaused:
		handle_confirm();
	pass

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
	in_game_ui.show();
	main_menu_scene.hide();
	continue_button.hide();

	victory_label.show();
	tile_grid.reset_tile_grid();

	# hmm
	player_manager.who_moves_first_next_round = player_manager.get_the_other_player(
		player_manager.who_moved_first_this_round
	)
	player_manager.active_player = player_manager.who_moves_first_next_round;
	player_manager.who_moved_first_this_round = player_manager.who_moves_first_next_round;

	game_manager.isGamePaused = false;
	pass;

func show_win():
	game_manager.isGamePaused = true;
	tile_grid.hide_focus_indicator();

	focus_continue_button();

	var active_player = get_key(
		Constants.TileMarkers,
		player_manager.active_player.marker
	);

	victory_label.hide();
	continue_button.show();
	continue_button.text = active_player + " Wins!"; 
	pass;

func show_tie():
	game_manager.isGamePaused = true;
	tile_grid.hide_focus_indicator();

	focus_continue_button()

	victory_label.hide();
	continue_button.show();
	continue_button.text = "Cat's Game!";
	pass;

func get_key(dictionary, index):
	return dictionary.keys()[index]

func reset_battle_text():
	victory_label.text = "Battle!";
	pass;

func _on_AI_turn_to_move():
	tile_grid.hide_focus_indicator();

	if !game_manager.isGamePaused:
		var potential_o_win = tile_grid.find_a_winning_move_for_player(Constants.TileMarkers.O);
		if potential_o_win:
			potential_o_win.choose(Constants.TileMarkers.O);
			return;

		var potential_x_win = tile_grid.find_a_winning_move_for_player(Constants.TileMarkers.X);
		if potential_x_win:
			potential_x_win.choose(Constants.TileMarkers.O);
			return;
	
		if player_manager.who_moved_first_this_round.type != Constants.PlayerTypes.AI:
			if tile_grid.is_center_tile_open():
				tile_grid.children[4].choose(Constants.TileMarkers.O);
				return;

		var random_diagonal = tile_grid.find_random_open_diagonal_for_ai();
		if random_diagonal:
			random_diagonal.choose(Constants.TileMarkers.O);
			return;

		var random_tile = tile_grid.find_random_open_tile_for_ai();
		if random_tile:
			random_tile.choose(Constants.TileMarkers.O);
	pass;

func _on_continue_pressed():
	if (
		player_manager.players.p1.score >= game_manager.wins_per_round or
		player_manager.players.p2.score >= game_manager.wins_per_round
	):
		scene_transitions.show();
		scene_transitions.fade_ap.queue("fade_to_black");
		await get_tree().create_timer(0.5).timeout

		in_game_ui.hide();
		main_menu_scene.show();
		scene_transitions.fade_ap.queue("fade_from_black");
		await get_tree().create_timer(0.5).timeout
		scene_transitions.hide();
		focus_player_switch();
		pass;
	else:
		set_up_next_round();

	pass

func _on_toggle_player_pressed():
	var pressed:bool = toggle_player_btn.button_pressed;

	toggle_player_switch.button_pressed = pressed;

	if pressed:
		player_manager.set_to_multiplayer();
	else:
		player_manager.set_to_singleplayer();
	pass

func _on_toggle_wins_pressed():
	var pressed:bool = toggle_wins_btn.button_pressed;

	toggle_wins_switch.button_pressed = pressed;

	if pressed:
		game_manager.wins_per_round = 5;
	else:
		game_manager.wins_per_round = 3;
	pass

func _on_start_game_button_pressed():
	scene_transitions.show();
	scene_transitions.diamond_ap.queue("to_black");
	player_manager.reset_who_moves_first();
	player_manager.reset_player_scores();
	tile_grid.reset_tile_grid();
	await get_tree().create_timer(1.0).timeout
	main_menu_scene.hide();
	in_game_ui.show();
	continue_button.hide();
	victory_label.show();
	scene_transitions.diamond_ap.queue("from_black");
	camera_ap.queue("begin_battle");
	await get_tree().create_timer(2.0).timeout
	scene_transitions.hide();
	game_manager.isGamePaused = false;
	pass

func _on_tile_grid_tile_hovered(tile):
	if !game_manager.isGamePaused:
		tile_grid.unfocus_all_tiles();
		tile.focus();
	else:
		tile_grid.unfocus_all_tiles();
	pass

func _on_scene_transitions_transition_started():
	scene_is_transitioning = true;
	print("start transition",scene_is_transitioning);
	pass

func _on_scene_transitions_transition_ended():
	scene_is_transitioning = false;
	print("end transition", scene_is_transitioning);
	pass
