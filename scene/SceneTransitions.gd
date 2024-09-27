extends CanvasLayer

@onready var animation_player = %AnimationPlayer
@onready var scene_transitions = %SceneTransitions

signal transition_started;
signal transition_ended;

func _ready():
	pass;

func start_transition():
	scene_transitions.show();
	transition_started.emit();
	pass;
	
func end_transition():
	scene_transitions.hide();
	transition_ended.emit();
	pass;

func diamond_to_black():
	start_transition();
	animation_player.queue("to_black");
	await get_tree().create_timer(1.0).timeout
	end_transition();
	pass;

func diamond_from_black():
	start_transition();
	
	animation_player.queue("from_black");
	await get_tree().create_timer(1.0).timeout
	end_transition();
	pass;
