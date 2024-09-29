extends CanvasLayer

@onready var scene_transitions: CanvasLayer = %SceneTransitions
@onready var diamond_ap: AnimationPlayer = %DiamondAP
@onready var fade_ap: AnimationPlayer = %FadeAP

signal transition_started;
signal transition_ended;

var isAnimating:bool = false;

func _ready():
	scene_transitions.hide();
	pass;

func diamond_to_black():
	diamond_ap.queue("to_black");
	pass;

func diamond_from_black():
	diamond_ap.queue("from_black");
	pass;

func fade_to_black():
	fade_ap.queue("to_black");
	pass;

func fade_from_black():
	fade_ap.queue("from_black");
	pass;
	
func started():
	scene_transitions.show();
	transition_started.emit()
	pass;

func ended():
	scene_transitions.hide();
	transition_ended.emit()
	pass;

func _on_diamond_ap_animation_started(anim_name: StringName) -> void:
	started();
	pass;

func _on_diamond_ap_animation_finished(anim_name: StringName) -> void:
	ended();
	pass

func _on_fade_ap_animation_started(anim_name: StringName) -> void:
	#print("AP started")
	started();
	pass

func _on_fade_ap_animation_finished(anim_name: StringName) -> void:
	#print("AP ended")
	ended();
	pass
