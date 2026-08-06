extends Node

const GAME = preload("res://scenes/game.tscn")
const SETTINGS = preload("res://scenes/settings.tscn")

var fade_node : CanvasLayer
var debug_mode : bool = true

const DEBUG_EASY_WIN : bool = false

enum game_states {
	START,
	GAME,
	END
}
var game_state : game_states = game_states.START
