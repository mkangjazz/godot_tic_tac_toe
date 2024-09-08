class_name Tile extends Node3D

signal focused_tile_was_clicked(tile:Tile);

@export var building_type: Constants.TileStates = Constants.TileStates.EMPTY;

@onready var focus_indicator = %MeshInstance3D

var isFocused:bool = false;

func _ready():
	pass;

func _physics_process(delta):
	if isFocused:
		focus_indicator.show();
	else:
		focus_indicator.hide();
	pass;

func _unhandled_input(event):
	if event.is_action("confirm") and not event.is_echo():
		if event.is_pressed():
			handle_click();
	pass;

# isFocused
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
	if !isFocused:
		return;
	
	focused_tile_was_clicked.emit(self);
	pass;

func blur():
	isFocused = false;
	pass;

func focus():
	isFocused = true;
	print("focus: ", isFocused);
	pass;

func get_selected_state():
	return isFocused;
	pass;
