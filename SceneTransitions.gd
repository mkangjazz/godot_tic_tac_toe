extends CanvasLayer

@onready var scene_transitions = %SceneTransitions
@onready var diamond_ap: AnimationPlayer = %DiamondAP
@onready var fade_ap: AnimationPlayer = %FadeAP

signal transition_started;
signal transition_ended;

func _ready():
	scene_transitions.hide();
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
	diamond_ap.queue("to_black");
	await get_tree().create_timer(1.0).timeout
	end_transition();
	pass;

func diamond_from_black():
	start_transition();
	
	diamond_ap.queue("from_black");
	await get_tree().create_timer(1.0).timeout
	end_transition();
	pass;

func fade_to_black():
	start_transition();
	fade_ap.queue("to_black");
	await get_tree().create_timer(0.5).timeout
	end_transition();
	pass;

func fade_from_black():
	start_transition();
	
	fade_ap.queue("from_black");
	await get_tree().create_timer(0.5).timeout
	end_transition();
	pass;
