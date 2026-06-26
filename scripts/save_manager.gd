class_name SaveManager
extends RefCounted

var current_stage_index := 0


func load_progress() -> int:
	return current_stage_index


func save_progress(stage_index: int) -> void:
	current_stage_index = stage_index

