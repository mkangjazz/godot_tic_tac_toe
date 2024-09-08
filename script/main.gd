extends Node3D

# track isPlaying or not
# track games (best of 5, alternate who goes first)

# track state of each tile
# empty, X, O

# could just reference each of the nodes in the tree TileGrid
# and access each one's state and check win conditions against it?
#@onready var tile_grid = %TileGrid
#var grid:Dictionary = {
#};

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

