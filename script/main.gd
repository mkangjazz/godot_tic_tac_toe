class_name Game
extends Node3D

# DEBUG
@onready var debug_label = %DebugLabel;
@onready var whose_turn = %WhoseTurn
@onready var reset_button = %Continue;

# 
@onready var controllers_container = %ControllersContainer
@onready var tile_grid = %TileGrid;

var win_manager:WinManager;
var player_manager:PlayerManager;

func _ready():
	set_up_managers();
	pass;

func _unhandled_input(event):
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

func set_up_managers():
	win_manager = WinManager.new();
	controllers_container.add_child(win_manager);

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
		
		# maybe we should wait before this
		# and do another check to see if the game is over
		player_manager.switch_active_player();

	pass;

func _on_tile_grid_matched_three_o():
	print("_on_tile_grid_matched_three_o");
	pass


func _on_tile_grid_matched_three_x():
	print("_on_tile_grid_matched_three_x");
	pass

func _on_tile_grid_no_empty_tiles_left():
	print("_on_tile_grid_no_empty_tiles_left");
	pass
