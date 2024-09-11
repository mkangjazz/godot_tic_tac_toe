class_name Tile extends Node3D

signal focused_tile_was_chosen;

@onready var focus_indicator = %FocusSelector
@onready var x_marker = %X
@onready var o_marker = %O

var isFocused:bool = false;
var building_type: Constants.TileMarkers = Constants.TileMarkers.EMPTY;

func _ready():
	pass;

func _physics_process(delta):
	match (building_type):
		Constants.TileMarkers.X:
			x_marker.show();
			o_marker.hide();
		Constants.TileMarkers.O:
			x_marker.hide();
			o_marker.show();
		_:
			x_marker.hide();
			o_marker.hide();
	pass;

func choose(type: Constants.TileMarkers):
	if !isFocused:
		return;

	if building_type != Constants.TileMarkers.EMPTY:
		return;

	building_type = type;
	focused_tile_was_chosen.emit();
	pass;

func blur():
	isFocused = false;
	focus_indicator.hide();
	pass;

func focus():
	isFocused = true;
	focus_indicator.show();
	pass;
