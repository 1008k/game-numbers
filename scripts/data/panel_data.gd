class_name PanelData
extends RefCounted

const TYPE_NUMBER := "number"
const TYPE_OPERATOR := "operator"

var id: int
var display_text: String
var value: Variant
var type: String
var used: bool = false


func _init(panel_id: int = 0, panel_text: String = "", panel_value: Variant = null, panel_type: String = TYPE_NUMBER) -> void:
	id = panel_id
	display_text = panel_text
	value = panel_value
	type = panel_type


func is_number() -> bool:
	return type == TYPE_NUMBER


func is_operator() -> bool:
	return type == TYPE_OPERATOR

