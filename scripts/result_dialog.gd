class_name ResultDialog
extends Control

signal home_requested
signal retry_requested
signal next_requested
signal revive_requested

const UI_THEME := preload("res://scripts/ui_theme.gd")

const ACTION_HOME := "home"
const ACTION_NEXT := "next"
const ACTION_RETRY := "retry"

var title_label: Label
var message_label: Label
var primary_button: Button
var revive_button: Button
var primary_action := ACTION_RETRY


func _ready() -> void:
	_build()


func show_result(title_text: String, message_text: String, primary_text: String, show_revive: bool, action := ACTION_RETRY) -> void:
	title_label.text = title_text
	message_label.text = message_text
	primary_button.text = primary_text
	primary_action = action
	revive_button.visible = show_revive
	visible = true


func _build() -> void:
	var shade := ColorRect.new()
	shade.color = Color(0, 0, 0, 0.58)
	shade.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(shade)

	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(center)

	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(310, 260)
	panel.add_theme_stylebox_override("panel", UI_THEME.panel_style(UI_THEME.SURFACE, 8, UI_THEME.DISPLAY, 2))
	center.add_child(panel)

	var layout := VBoxContainer.new()
	layout.alignment = BoxContainer.ALIGNMENT_CENTER
	layout.add_theme_constant_override("separation", 12)
	panel.add_child(layout)

	title_label = Label.new()
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	UI_THEME.apply_label(title_label, UI_THEME.TEXT, 28)
	layout.add_child(title_label)

	message_label = Label.new()
	message_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	message_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	UI_THEME.apply_label(message_label, UI_THEME.MUTED_TEXT, 16)
	layout.add_child(message_label)

	primary_button = Button.new()
	primary_button.custom_minimum_size = Vector2(200, 52)
	UI_THEME.apply_button(primary_button, UI_THEME.KEY_ACTION)
	primary_button.pressed.connect(_on_primary_pressed)
	layout.add_child(primary_button)

	revive_button = Button.new()
	revive_button.text = "広告で復活"
	revive_button.custom_minimum_size = Vector2(200, 52)
	UI_THEME.apply_button(revive_button, UI_THEME.KEY_OPERATOR)
	revive_button.pressed.connect(func() -> void: revive_requested.emit())
	layout.add_child(revive_button)

	var home_button := Button.new()
	home_button.text = "ホームへ戻る"
	home_button.custom_minimum_size = Vector2(200, 52)
	UI_THEME.apply_button(home_button, UI_THEME.SURFACE, UI_THEME.TEXT)
	home_button.pressed.connect(func() -> void: home_requested.emit())
	layout.add_child(home_button)


func _on_primary_pressed() -> void:
	match primary_action:
		ACTION_NEXT:
			next_requested.emit()
		ACTION_HOME:
			home_requested.emit()
		_:
			retry_requested.emit()
	hide()
