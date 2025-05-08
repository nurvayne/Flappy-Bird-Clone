extends Node


@onready var birb: Birb = $"../Birb" 
@onready var pipe_spawn: PipeSpawn = $"../PipeSpawn" 
@onready var ground: Ground = $"../Ground"
@onready var fade: Fade = $"../Fade"
@onready var ui: UI = $"../UI"



var points = 0

func _ready() -> void:
	birb.game_started.connect(on_game_started)
	ground.birb_crashed.connect(end_game)
	pipe_spawn.birb_crashed.connect(end_game)
	pipe_spawn.point_scored.connect(on_point_scored)

func on_game_started():
	pipe_spawn.start_timer()

func end_game():
	if fade != null:
		fade.play()
	ground.stop()
	birb.kill()
	pipe_spawn.stop()
	ui.on_game_over()

func on_point_scored():
	points += 1
	ui.update_points(points)
	print(points)
