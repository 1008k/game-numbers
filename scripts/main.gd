extends Control

const HOME_SCENE := preload("res://scenes/HomeScreen.tscn")
const GAME_SCENE := preload("res://scenes/GameScreen.tscn")
const GAME_MANAGER_SCRIPT := preload("res://scripts/game_manager.gd")

var current_screen: Control
var manager = GAME_MANAGER_SCRIPT.new()


func _ready() -> void:
	_show_home()


func _show_home() -> void:
	_clear_screen()
	var home = HOME_SCENE.instantiate()
	home.start_requested.connect(_start_game)
	current_screen = home
	add_child(current_screen)


func _start_game() -> void:
	manager.start_first_stage()
	_show_game()


func _restart_game() -> void:
	manager.retry_stage()


func _next_stage() -> void:
	manager.start_next_stage()


func _show_game() -> void:
	_clear_screen()
	var game = GAME_SCENE.instantiate()
	game.home_requested.connect(_show_home)
	game.retry_requested.connect(_restart_game)
	game.next_stage_requested.connect(_next_stage)
	game.setup(manager)
	current_screen = game
	add_child(current_screen)


func _clear_screen() -> void:
	if current_screen != null:
		current_screen.queue_free()
		current_screen = null
