class_name WinManager
extends Node

func _ready():
	print('WinManager ready');
	pass;

# what signals need to be sent up?
# can we just call functions from here?
# signal is_x_win
# signal is_o_win
# signal is_tie
#signal game_is_won (winner: Constants.TileMarkers);
#signal game_is_tie;

#func show_win_scene():
	#print("show_win_screen")
	#pass;
#
#func show_tie_scene():
	#print("");
	#pass;

#func _on_tile_grid_game_is_won(winner: Constants.TileMarkers):
	#tile_grid.disableTileGrid();
#
	#var str:String = "";
#
	#match winner:
		#Constants.TileMarkers.X:
			#str = "X wins!";
		#Constants.TileMarkers.O:
			#str = "O wins!";
#
	#debug_label.text = str;
	#print(str);
	#pass
#
#func _on_tile_grid_game_is_tie():
	#tile_grid.disableTileGrid();
#
	#debug_label.text = "Cat's Game";
	#pass
#
#func _on_continue_pressed():
	#set_up_new_game();
	#pass
