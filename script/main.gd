class_name Game
extends Node3D

func _ready():
	pass;
# Player is X, CPU is Y
# How to control who goes first?
# control p1 and p2,
# or X and O (void EMPTY)

# track state of each tile
# empty, X, O

# track whose turn it is
# player, CPU

# win, lose, or tie
# win conditions
# if xxx or ooo

# tie conditions
# empty no moves left on board
# no possible way to win (no combinations of 3)

# CPU decides where to place an O

# game timer?
func set_up_new_game():
	# set all tile states back to empty
	pass;

func _on_tile_grid_game_is_won(winner: Constants.TileStates):
	match winner:
		Constants.TileStates.X:
			print("X wins!");
		Constants.TileStates.O:
			print("O wins!");
	pass
