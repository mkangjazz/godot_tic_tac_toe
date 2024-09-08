extends Node3D

# signal grid_changed

func _ready():
	focus_tile_at_index(0);
	get_focused_tile();
	
	#for child in get_children():
		#child.connect()
		
	pass;

func _unhandled_input(event):
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

	if target_index > get_children().size() - 1:
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

	if target_index > get_children().size() - 1:
		return;

	focus_tile_at_index(target_index);
	pass;

func unfocus_all_tiles():
	for tile in get_children():
		tile.blur();
	pass;

func focus_tile_at_index(index:int):
	var tile = get_child(index);

	unfocus_all_tiles();
	tile.focus();
	print("focus: ", tile);
	
	pass;

func get_focused_tile():
	var tile:Tile;

	for child in get_children():
		if child.get_selected_state():
			tile = child;
		pass;

	return tile;
	pass;

func _on_zero_zero_focused_tile_was_clicked(tile):
	print("clicky 0")
	pass # Replace with function body.

func _on_one_zero_focused_tile_was_clicked(tile):
	print("clicky 1")
	pass # Replace with function body.

func _on_two_zero_focused_tile_was_clicked(tile):
	print("clicky 2")
	pass # Replace with function body.

func _on_zero_one_focused_tile_was_clicked(tile):
	print("clicky 3")
	pass # Replace with function body.

func _on_one_one_focused_tile_was_clicked(tile):
	print("clicky 4")
	pass # Replace with function body.

func _on_two_one_focused_tile_was_clicked(tile):
	print("clicky 5")
	pass # Replace with function body.

func _on_zero_two_focused_tile_was_clicked(tile):
	print("clicky 6")
	pass # Replace with function body.

func _on_one_two_focused_tile_was_clicked(tile):
	print("clicky 7")
	pass # Replace with function body.

func _on_two_two_focused_tile_was_clicked(tile):
	print("clicky 8")
	pass # Replace with function body.
