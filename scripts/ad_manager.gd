class_name AdManager
extends RefCounted

var revived_this_stage := false


func reset_stage() -> void:
	revived_this_stage = false


func can_revive() -> bool:
	return not revived_this_stage


func request_rewarded_revive() -> bool:
	if revived_this_stage:
		return false
	revived_this_stage = true
	return true

