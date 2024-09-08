class_name Tile extends Node3D

signal clicked(tile:Tile);

var isSelected:bool = false;

@export var building_type: Constants.TileStates = Constants.TileStates.EMPTY;

# isSelected
# texture?
# Dynamically instance children conditionally
# Empty, X, O

# event emitter (signal)
# should emit an event if
# clicked or "enter/spacebar"
# keyboard direction pressed:
# wasd, arrow keys (navigate the grid)

func set_building_type(type: Constants.TileStates):
	building_type = type;
	pass;

func handle_click():
	print("handle_click: ", self);
	# X or O based on whose turn it is?
	# emit the clicked signal and pass in which tile it was (self?)
	pass;

func blur():
	isSelected = false;
	pass;

func focus():
	isSelected = true;
	print("focus: ", isSelected);
	pass;

func get_selected_state():
	return isSelected;
	pass;
