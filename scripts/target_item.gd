class_name TargetItem
extends Button

signal target_selected(index: int)

const UI_THEME := preload("res://scripts/ui_theme.gd")

var target_index := 0


func setup(index: int, value: Variant, cleared: bool, selected: bool) -> void:
	target_index = index
	text = str(value)
	disabled = cleared
	if cleared:
		text = "%s ✓" % value
		UI_THEME.apply_button(self, UI_THEME.SUCCESS)
	elif selected:
		UI_THEME.apply_button(self, UI_THEME.KEY_ACTION)
	else:
		UI_THEME.apply_button(self, UI_THEME.GOAL, UI_THEME.TEXT)
	add_theme_font_size_override("font_size", 22)


func _ready() -> void:
	pressed.connect(func() -> void: target_selected.emit(target_index))
