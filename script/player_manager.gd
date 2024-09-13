class_name PlayerManager
extends Node

signal AI_turn_to_move;

const p1_marker = Constants.TileMarkers.X;
const p2_marker = Constants.TileMarkers.O;

var players:Dictionary = {
	"p1": {
		"type": Constants.PlayerTypes.PLAYER,
		"marker": Constants.TileMarkers.X,
		"score": 0,
	},
	"p2": {
		"type": Constants.PlayerTypes.PLAYER,
		"marker": Constants.TileMarkers.O,
		"score": 0,
	}
};

var who_moved_first_this_round:Dictionary = players.p1;
var who_moves_first_next_round:Dictionary = players.p1;
var active_player: Dictionary = players.p1;

func _ready():
	pass;

func _physics_process(delta):
	if active_player.type == Constants.PlayerTypes.AI:
		AI_turn_to_move.emit()

	pass;

func get_the_other_player(player:Dictionary) -> Dictionary:
	match (player):
		players.p1:
			return players.p2;
		players.p2:
			return players.p1;
		_:
			return {};
	pass;

func switch_active_player():
	active_player = get_the_other_player(active_player);

	pass;

func set_to_singleplayer():
	players["p2"].type = Constants.PlayerTypes.AI
	pass;

func set_to_multiplayer():
	players["p2"].type = Constants.PlayerTypes.PLAYER
	pass;
