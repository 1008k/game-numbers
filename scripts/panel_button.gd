class_name PanelButton
extends Button

signal panel_selected(panel)

const UI_THEME := preload("res://scripts/ui_theme.gd")

var panel_data


func setup(panel, selected := false) -> void:
	panel_data = panel
	text = panel.display_text
	disabled = panel.used
	if panel.used:
		text = "%s ✓" % panel.display_text
		modulate = Color(1, 1, 1, 0.62)
		UI_THEME.apply_button(self, UI_THEME.KEY_DISABLED, UI_THEME.MUTED_TEXT)
	elif selected:
		modulate = Color.WHITE
		UI_THEME.apply_button(self, UI_THEME.KEY_ACTION)
	elif panel.is_operator():
		modulate = Color.WHITE
		UI_THEME.apply_button(self, UI_THEME.KEY_OPERATOR)
	else:
		modulate = Color.WHITE
		UI_THEME.apply_button(self, UI_THEME.KEY_NUMBER)
	add_theme_font_size_override("font_size", 24)


func _ready() -> void:
	pressed.connect(func() -> void: panel_selected.emit(panel_data))
