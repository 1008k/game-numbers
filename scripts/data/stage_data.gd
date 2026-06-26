class_name StageData
extends RefCounted

var targets: Array = []
var panels: Array = []
var solutions: Array = []
var difficulty: int = 1
var max_mistakes: int = 3
var title: String = ""
var hint: String = ""


func _init(stage_targets: Array = [], stage_panels: Array = [], stage_solutions: Array = [], stage_difficulty: int = 1, mistakes: int = 3, stage_title: String = "", stage_hint: String = "") -> void:
	targets = stage_targets
	panels = stage_panels
	solutions = stage_solutions
	difficulty = stage_difficulty
	max_mistakes = mistakes
	title = stage_title
	hint = stage_hint
