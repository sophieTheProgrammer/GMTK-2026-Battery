extends Node


const START = preload("res://scenes/start.tscn")
const GAME = preload("res://scenes/game.tscn")
const SETTINGS = preload("res://scenes/settings.tscn")
const TUTORIAL = preload("res://scenes/cutscene_tutorial.tscn")

var fade_node : CanvasLayer
var debug_mode : bool = true

const DEBUG_EASY_WIN : bool = true
