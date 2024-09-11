class_name PlayerManager
extends Node

#should i move all actions/inputs to main instead of lower?
#signal whose_turn_is_it
#signal turn_ended
#signal ai_turn_ended
# could set two cursors...

const p1_marker = Constants.TileMarkers.X;
const p2_marker = Constants.TileMarkers.O;

var players:Dictionary = {
	"p1": {
		"type": Constants.PlayerTypes.PLAYER,
		"marker": Constants.TileMarkers.X
	},
	"p2": {
		"type": Constants.PlayerTypes.PLAYER,
		"marker": Constants.TileMarkers.O
	}
};
var who_moved_first_last_round:Dictionary = players.p2;
var who_moves_first_this_round:Dictionary;
var active_player: Dictionary;

func _ready():
	# set_up_new_game();
	# set_up_singleplayer();
	set_up_new_round();

	print("who_moves_first_this_round ", who_moves_first_this_round) 
	print("active_player ", active_player)

	pass;

func _physics_process(delta):
	pass;

func switch_player_turns():
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

func set_up_new_game():
	#set_to_multiplayer();
	#alternate_starting_player();
	#set_up_first_turn();

	#print("who moves first this round? ", who_moves_first_this_round)
	#print("whose turn now? ", active_player);
	pass;

func set_up_new_round():
	figure_out_who_moves_first();

	pass;

func switch_active_player():
	active_player = get_the_other_player(active_player);
	pass;

func figure_out_who_moves_first():
	who_moves_first_this_round = get_the_other_player(
		who_moved_first_last_round
	);
	active_player = who_moves_first_this_round;
	pass;

func set_to_singleplayer():
	players["p2"].type = Constants.PlayerTypes.AI
	pass;

func set_to_multiplayer():
	players["p2"].type = Constants.PlayerTypes.PLAYER
	pass;

func give_ai_a_turn():
	#print("run ai instrux")
	## choose a good move for AI, 
	## then turn back to player turn
	#
	## choose a random open square and place an "O"
	#ai_turn_ended.emit();

	pass

# do we even need this check?
func is_player_an_ai(player:Dictionary) -> bool:
	if player.type == Constants.PlayerTypes.AI:
		return true;
	else:
		return false;
	pass;
