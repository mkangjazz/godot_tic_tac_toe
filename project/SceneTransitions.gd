extends CanvasLayer

@onready var scene_transitions: CanvasLayer = %SceneTransitions
@onready var diamond_ap: AnimationPlayer = %DiamondAP
@onready var fade_ap: AnimationPlayer = %FadeAP
@onready var vertical_shutter_ap: AnimationPlayer = %VerticalShutterAP
#
@onready var diamond_rect: ColorRect = %DiamondRect
@onready var fade_rect: ColorRect = %FadeRect
@onready var v_shutter_rect: ColorRect = %VShutterRect

signal transition_started;
signal transition_ended;

var isAnimating:bool = false;

func _ready():
	scene_transitions.hide();
	pass;

func hide_all_rects():
	diamond_rect.hide();
	fade_rect.hide();
	v_shutter_rect.hide();
	pass;

func diamond_to_black():
	hide_all_rects();
	diamond_rect.show();
	diamond_ap.queue("to_black");
	pass;

func diamond_from_black():
	hide_all_rects();
	diamond_rect.show();
	diamond_ap.queue("from_black");
	pass;

func fade_to_black():
	hide_all_rects();
	fade_rect.show();
	fade_ap.queue("to_black");
	pass;

func fade_from_black():
	hide_all_rects();
	fade_rect.show();
	fade_ap.queue("from_black");
	pass;

func shutter_to_black():
	hide_all_rects();
	v_shutter_rect.show();
	vertical_shutter_ap.queue("to_black");
	pass;

func shutter_from_black():
	hide_all_rects();
	v_shutter_rect.show();
	vertical_shutter_ap.queue("from_black");
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
	started();
	pass

func _on_fade_ap_animation_finished(anim_name: StringName) -> void:
	ended();
	pass

func _on_vertical_shutter_ap_animation_started(anim_name: StringName) -> void:
	started();
	pass

func _on_vertical_shutter_ap_animation_finished(anim_name: StringName) -> void:
	ended();
	pass
