class_name GameManager
extends Node

const numerals:Dictionary = {
	"0": "",
	"1": "I",
	"2": "II",
	"3": "III",
	"4": "IV",
	"5": "V",
};

var isGamePaused = true;
var wins_per_round:int = 3;
var current_round:int = 0;

func reset_default_game_settings():
	wins_per_round = 3;
	current_round = 0;
	pass;
