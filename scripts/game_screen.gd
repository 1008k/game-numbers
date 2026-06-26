class_name GameScreen
extends Control

signal home_requested
signal retry_requested
signal next_stage_requested

const PANEL_BUTTON_SCENE := preload("res://scenes/PanelButton.tscn")
const TARGET_ITEM_SCENE := preload("res://scenes/TargetItem.tscn")
const RESULT_DIALOG_SCENE := preload("res://scenes/ClearDialog.tscn")
const GAME_MANAGER_SCRIPT := preload("res://scripts/game_manager.gd")
const UI_THEME := preload("res://scripts/ui_theme.gd")

var manager
var target_row: HBoxContainer
var stage_label: Label
var expression_label: Label
var message_label: Label
var mistake_label: Label
var panel_grid: GridContainer
var result_dialog
var flash_rect: ColorRect


func setup(game_manager) -> void:
	manager = game_manager


func _ready() -> void:
	if manager == null:
		manager = GAME_MANAGER_SCRIPT.new()
		manager.start_first_stage()
	_build()
	manager.changed.connect(_refresh)
	manager.feedback.connect(_play_feedback)
	manager.stage_cleared.connect(_show_clear)
	manager.game_over.connect(_show_game_over)
	_refresh()


func _build() -> void:
	UI_THEME.fill_background(self)
	var root := MarginContainer.new()
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	root.add_theme_constant_override("margin_left", 18)
	root.add_theme_constant_override("margin_right", 18)
	root.add_theme_constant_override("margin_top", 24)
	root.add_theme_constant_override("margin_bottom", 18)
	add_child(root)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 14)
	root.add_child(layout)

	var top_bar := HBoxContainer.new()
	layout.add_child(top_bar)

	var home_button := Button.new()
	home_button.text = "ホーム"
	UI_THEME.apply_button(home_button, UI_THEME.SURFACE, UI_THEME.TEXT)
	home_button.pressed.connect(func() -> void: home_requested.emit())
	top_bar.add_child(home_button)

	mistake_label = Label.new()
	mistake_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	mistake_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	UI_THEME.apply_label(mistake_label, UI_THEME.WARNING, 16)
	top_bar.add_child(mistake_label)

	stage_label = Label.new()
	stage_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	UI_THEME.apply_label(stage_label, UI_THEME.TEXT, 22)
	layout.add_child(stage_label)

	target_row = HBoxContainer.new()
	target_row.alignment = BoxContainer.ALIGNMENT_CENTER
	target_row.add_theme_constant_override("separation", 8)
	layout.add_child(target_row)

	expression_label = Label.new()
	expression_label.custom_minimum_size = Vector2(0, 72)
	expression_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	expression_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	expression_label.add_theme_color_override("font_color", UI_THEME.BACKGROUND)
	expression_label.add_theme_font_size_override("font_size", 34)
	expression_label.add_theme_stylebox_override("normal", UI_THEME.panel_style(UI_THEME.DISPLAY, 8))
	layout.add_child(expression_label)

	message_label = Label.new()
	message_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	message_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	UI_THEME.apply_label(message_label, UI_THEME.MUTED_TEXT, 15)
	layout.add_child(message_label)

	panel_grid = GridContainer.new()
	panel_grid.columns = 4
	panel_grid.size_flags_vertical = Control.SIZE_EXPAND_FILL
	panel_grid.add_theme_constant_override("h_separation", 8)
	panel_grid.add_theme_constant_override("v_separation", 8)
	layout.add_child(panel_grid)

	flash_rect = ColorRect.new()
	flash_rect.color = Color.TRANSPARENT
	flash_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	flash_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(flash_rect)

	var action_row := HBoxContainer.new()
	action_row.alignment = BoxContainer.ALIGNMENT_CENTER
	action_row.add_theme_constant_override("separation", 8)
	layout.add_child(action_row)

	var undo_button := Button.new()
	undo_button.text = "1手戻す"
	UI_THEME.apply_button(undo_button, UI_THEME.SURFACE, UI_THEME.TEXT)
	undo_button.pressed.connect(func() -> void: manager.undo_expression())
	action_row.add_child(undo_button)

	var clear_button := Button.new()
	clear_button.text = "組み直す"
	UI_THEME.apply_button(clear_button, UI_THEME.SURFACE, UI_THEME.TEXT)
	clear_button.pressed.connect(func() -> void: manager.clear_expression())
	action_row.add_child(clear_button)

	var retry_button := Button.new()
	retry_button.text = "最初から"
	UI_THEME.apply_button(retry_button, UI_THEME.SURFACE, UI_THEME.TEXT)
	retry_button.pressed.connect(func() -> void: retry_requested.emit())
	action_row.add_child(retry_button)

	result_dialog = RESULT_DIALOG_SCENE.instantiate()
	result_dialog.home_requested.connect(func() -> void: home_requested.emit())
	result_dialog.retry_requested.connect(func() -> void: retry_requested.emit())
	result_dialog.next_requested.connect(func() -> void: next_stage_requested.emit())
	result_dialog.revive_requested.connect(_revive)
	add_child(result_dialog)


func _refresh() -> void:
	_rebuild_targets()
	_rebuild_panels()
	stage_label.text = manager.get_stage_label()
	mistake_label.text = "やり直し: %s" % max(manager.remaining_mistakes, 0)
	var expression_text = manager.get_current_expression_text()
	if expression_text == "":
		expression_text = "タイルを選ぶ"
	expression_label.text = expression_text
	expression_label.pivot_offset = expression_label.size * 0.5
	message_label.text = manager.last_message


func _rebuild_targets() -> void:
	for child in target_row.get_children():
		child.queue_free()
	for index in range(manager.target_states.size()):
		var target = TARGET_ITEM_SCENE.instantiate()
		var target_state = manager.target_states[index]
		target.setup(index, target_state["value"], target_state["cleared"], index == manager.selected_target_index)
		target.target_selected.connect(func(selected_index: int) -> void: manager.select_target(selected_index))
		target_row.add_child(target)


func _rebuild_panels() -> void:
	for child in panel_grid.get_children():
		child.queue_free()
	for panel in manager.stage.panels:
		var button = PANEL_BUTTON_SCENE.instantiate()
		button.setup(panel, _is_panel_selected(panel))
		button.panel_selected.connect(func(selected_panel) -> void: manager.select_panel(selected_panel))
		panel_grid.add_child(button)


func _show_clear() -> void:
	var clear_message := "全部ぴったり! タイル配分成功"
	if manager.has_next_stage():
		result_dialog.show_result("ステージクリア", clear_message, "次へ", false, result_dialog.ACTION_NEXT)
	else:
		result_dialog.show_result("全ステージクリア", "最後までぴったり! 見事な配分です", "ホームへ", false, result_dialog.ACTION_HOME)


func _show_game_over() -> void:
	result_dialog.show_result("ゲームオーバー", "やり直しがなくなりました", "リトライ", manager.can_revive(), result_dialog.ACTION_RETRY)


func _revive() -> void:
	if manager.revive_with_reward():
		result_dialog.hide()


func _is_panel_selected(panel) -> bool:
	for expression_panel in manager.expression_panels:
		if expression_panel.id == panel.id:
			return true
	return false


func _play_feedback(kind: String) -> void:
	match kind:
		"tap":
			_pulse(expression_label, 1.04, 0.08)
		"correct":
			_flash(UI_THEME.SUCCESS, 0.24)
			_pulse(expression_label, 1.1, 0.12)
			_pulse(target_row, 1.05, 0.12)
		"clear":
			_flash(UI_THEME.KEY_ACTION, 0.32)
			_pulse(expression_label, 1.14, 0.14)
			_pulse(target_row, 1.08, 0.14)
		"mistake":
			_flash(UI_THEME.ERROR, 0.28)
			_shake(expression_label)
		"bump":
			_shake(expression_label, 4.0, 0.12)


func _pulse(node: Control, peak_scale: float, duration: float) -> void:
	node.pivot_offset = node.size * 0.5
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(node, "scale", Vector2(peak_scale, peak_scale), duration)
	tween.tween_property(node, "scale", Vector2.ONE, duration)


func _flash(color: Color, alpha: float) -> void:
	flash_rect.color = Color(color.r, color.g, color.b, alpha)
	var tween := create_tween()
	tween.tween_property(flash_rect, "color:a", 0.0, 0.28)


func _shake(node: Control, distance := 8.0, duration := 0.18) -> void:
	var base_position := node.position
	var tween := create_tween()
	tween.tween_property(node, "position:x", base_position.x - distance, duration * 0.25)
	tween.tween_property(node, "position:x", base_position.x + distance, duration * 0.25)
	tween.tween_property(node, "position:x", base_position.x - distance * 0.5, duration * 0.25)
	tween.tween_property(node, "position:x", base_position.x, duration * 0.25)
