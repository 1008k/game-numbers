class_name HomeScreen
extends Control

signal start_requested

const UI_THEME := preload("res://scripts/ui_theme.gd")


func _ready() -> void:
	_build()


func _build() -> void:
	UI_THEME.fill_background(self)
	var root := MarginContainer.new()
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	root.add_theme_constant_override("margin_left", 28)
	root.add_theme_constant_override("margin_right", 28)
	root.add_theme_constant_override("margin_top", 48)
	root.add_theme_constant_override("margin_bottom", 48)
	add_child(root)

	var layout := VBoxContainer.new()
	layout.alignment = BoxContainer.ALIGNMENT_CENTER
	layout.add_theme_constant_override("separation", 20)
	root.add_child(layout)

	var title := Label.new()
	title.text = "ナンバータイル"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	UI_THEME.apply_label(title, UI_THEME.TEXT, 34)
	layout.add_child(title)

	var subtitle := Label.new()
	subtitle.text = "数字タイルをゴールに割り振って、全部ぴったり埋めよう"
	subtitle.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	UI_THEME.apply_label(subtitle, UI_THEME.MUTED_TEXT, 16)
	layout.add_child(subtitle)

	var start_button := Button.new()
	start_button.text = "スタート"
	start_button.custom_minimum_size = Vector2(220, 64)
	UI_THEME.apply_button(start_button, UI_THEME.KEY_ACTION)
	start_button.pressed.connect(func() -> void: start_requested.emit())
	layout.add_child(start_button)

	var note := Label.new()
	note.text = "試作版: 手作りステージを3つ遊べます"
	note.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	UI_THEME.apply_label(note, UI_THEME.MUTED_TEXT, 14)
	layout.add_child(note)
