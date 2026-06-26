class_name StageGenerator
extends RefCounted

const PANEL_DATA_SCRIPT := preload("res://scripts/data/panel_data.gd")
const STAGE_DATA_SCRIPT := preload("res://scripts/data/stage_data.gd")


static func stage_count() -> int:
	return 5


static func create_stage(index: int):
	match index:
		0:
			return _stage_tutorial()
		1:
			return _stage_shared_resource()
		2:
			return _stage_order_puzzle()
		3:
			return _stage_decoy_puzzle()
		4:
			return _stage_operator_choice()
		_:
			return _stage_operator_choice()


static func create_first_stage():
	return create_stage(0)


static func _stage_tutorial():
	var panels: Array = [
		_number(1, "3", 3),
		_number(2, "4", 4),
		_number(3, "5", 5),
		_number(4, "2", 2),
		_number(5, "24", 24),
		_number(6, "3", 3),
		_operator(101, "+"),
		_operator(102, "×"),
		_operator(103, "÷"),
	]
	var solutions := [
		{"target": 12, "expression": "3 × 4"},
		{"target": 7, "expression": "5 + 2"},
		{"target": 8, "expression": "24 ÷ 3"},
	]
	return STAGE_DATA_SCRIPT.new([12, 7, 8], panels, solutions, 1, 3, "Stage 1", "まずはタイルをぴったり使い切ろう")


static func _stage_shared_resource():
	var panels: Array = [
		_number(1, "6", 6),
		_number(2, "2", 2),
		_number(3, "9", 9),
		_number(4, "3", 3),
		_number(5, "5", 5),
		_number(6, "1", 1),
		_operator(101, "×"),
		_operator(102, "÷"),
		_operator(103, "-"),
	]
	var solutions := [
		{"target": 12, "expression": "6 × 2"},
		{"target": 3, "expression": "9 ÷ 3"},
		{"target": 4, "expression": "5 - 1"},
	]
	return STAGE_DATA_SCRIPT.new([12, 3, 4], panels, solutions, 2, 3, "Stage 2", "大きいゴールから使うタイルを考えよう")


static func _stage_order_puzzle():
	var panels: Array = [
		_number(1, "14", 14),
		_number(2, "6", 6),
		_number(3, "18", 18),
		_number(4, "3", 3),
		_number(5, "7", 7),
		_number(6, "5", 5),
		_number(7, "2", 2),
		_operator(101, "-"),
		_operator(102, "÷"),
		_operator(103, "+"),
	]
	var solutions := [
		{"target": 8, "expression": "14 - 6"},
		{"target": 6, "expression": "18 ÷ 3"},
		{"target": 12, "expression": "7 + 5"},
	]
	return STAGE_DATA_SCRIPT.new([8, 6, 12], panels, solutions, 3, 3, "Stage 3", "数字の使い道を先に決めすぎないのがコツ")


static func _stage_decoy_puzzle():
	var panels: Array = [
		_number(1, "8", 8),
		_number(2, "4", 4),
		_number(3, "15", 15),
		_number(4, "3", 3),
		_number(5, "9", 9),
		_number(6, "6", 6),
		_number(7, "1", 1),
		_operator(101, "+"),
		_operator(102, "-"),
		_operator(103, "÷"),
	]
	var solutions := [
		{"target": 12, "expression": "8 + 4"},
		{"target": 5, "expression": "15 ÷ 3"},
		{"target": 3, "expression": "9 - 6"},
	]
	return STAGE_DATA_SCRIPT.new([12, 5, 3], panels, solutions, 4, 3, "Stage 4", "余った数字に惑わされず、ぴったり使える組を探そう")


static func _stage_operator_choice():
	var panels: Array = [
		_number(1, "10", 10),
		_number(2, "2", 2),
		_number(3, "8", 8),
		_number(4, "4", 4),
		_number(5, "21", 21),
		_number(6, "7", 7),
		_number(7, "6", 6),
		_operator(101, "-"),
		_operator(102, "÷"),
		_operator(103, "+"),
	]
	var solutions := [
		{"target": 8, "expression": "10 - 2"},
		{"target": 2, "expression": "8 ÷ 4"},
		{"target": 28, "expression": "21 + 7"},
	]
	return STAGE_DATA_SCRIPT.new([8, 2, 28], panels, solutions, 5, 3, "Stage 5", "記号タイルも限られた資源。先に使い道を見よう")


static func _number(id: int, text: String, value: int):
	return PANEL_DATA_SCRIPT.new(id, text, value, PANEL_DATA_SCRIPT.TYPE_NUMBER)


static func _operator(id: int, text: String):
	return PANEL_DATA_SCRIPT.new(id, text, text, PANEL_DATA_SCRIPT.TYPE_OPERATOR)
