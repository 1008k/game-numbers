class_name UiTheme
extends RefCounted

const BACKGROUND := Color("#f6f1e8")
const SURFACE := Color("#fffaf0")
const DISPLAY := Color("#fff3c4")
const TEXT := Color("#243447")
const MUTED_TEXT := Color("#687385")
const KEY_NUMBER := Color("#ffffff")
const KEY_OPERATOR := Color("#d8f3ff")
const KEY_ACTION := Color("#ffcf70")
const KEY_DISABLED := Color("#d9d2c6")
const SUCCESS := Color("#b8f2c2")
const WARNING := Color("#f2a65a")
const ERROR := Color("#ff8a8a")
const GOAL := Color("#e5dcff")


static func fill_background(node: Control) -> ColorRect:
	var background := ColorRect.new()
	background.color = BACKGROUND
	background.set_anchors_preset(Control.PRESET_FULL_RECT)
	node.add_child(background)
	node.move_child(background, 0)
	return background


static func panel_style(color: Color, radius: int = 8, border_color: Color = Color.TRANSPARENT, border_width: int = 0) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.corner_radius_top_left = radius
	style.corner_radius_top_right = radius
	style.corner_radius_bottom_left = radius
	style.corner_radius_bottom_right = radius
	style.border_color = border_color
	style.border_width_left = border_width
	style.border_width_top = border_width
	style.border_width_right = border_width
	style.border_width_bottom = border_width
	style.content_margin_left = 10
	style.content_margin_right = 10
	style.content_margin_top = 8
	style.content_margin_bottom = 8
	return style


static func apply_button(button: Button, color: Color, text_color: Color = TEXT) -> void:
	var normal := panel_style(color, 8, Color("#d7ccbd"), 1)
	var hover := panel_style(color.lightened(0.05), 8, Color("#c8bba9"), 1)
	var pressed := panel_style(color.darkened(0.08), 8, Color("#b7a993"), 1)
	var disabled := panel_style(KEY_DISABLED, 8, Color("#c4bbaf"), 1)
	button.add_theme_stylebox_override("normal", normal)
	button.add_theme_stylebox_override("hover", hover)
	button.add_theme_stylebox_override("pressed", pressed)
	button.add_theme_stylebox_override("disabled", disabled)
	button.add_theme_color_override("font_color", text_color)
	button.add_theme_color_override("font_hover_color", text_color)
	button.add_theme_color_override("font_pressed_color", text_color)
	button.add_theme_color_override("font_disabled_color", MUTED_TEXT)


static func apply_label(label: Label, color: Color = TEXT, font_size: int = 16) -> void:
	label.add_theme_color_override("font_color", color)
	label.add_theme_font_size_override("font_size", font_size)
