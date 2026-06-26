class_name GameManager
extends RefCounted

const AD_MANAGER_SCRIPT := preload("res://scripts/ad_manager.gd")
const EXPRESSION_EVALUATOR_SCRIPT := preload("res://scripts/expression_evaluator.gd")
const SOUND_MANAGER_SCRIPT := preload("res://scripts/sound_manager.gd")
const STAGE_GENERATOR_SCRIPT := preload("res://scripts/stage_generator.gd")

signal changed
signal feedback(kind: String)
signal stage_cleared
signal game_over

var stage
var ad_manager = AD_MANAGER_SCRIPT.new()
var sound_manager = SOUND_MANAGER_SCRIPT.new()
var selected_target_index := 0
var target_states: Array = []
var expression_panels: Array = []
var remaining_mistakes := 3
var last_message := ""
var stage_index := 0
var combo_count := 0


func start_first_stage() -> void:
	stage_index = 0
	_start_stage(stage_index)


func start_next_stage() -> void:
	if not has_next_stage():
		return
	stage_index += 1
	_start_stage(stage_index)


func retry_stage() -> void:
	_start_stage(stage_index)


func get_stage_label() -> String:
	if stage == null:
		return ""
	if stage.title != "":
		return stage.title
	return "Stage %s" % (stage_index + 1)


func has_next_stage() -> bool:
	return stage_index + 1 < STAGE_GENERATOR_SCRIPT.stage_count()


func _start_stage(index: int) -> void:
	stage = STAGE_GENERATOR_SCRIPT.create_stage(index)
	ad_manager.reset_stage()
	selected_target_index = 0
	expression_panels.clear()
	remaining_mistakes = stage.max_mistakes
	combo_count = 0
	last_message = stage.hint if stage.hint != "" else "ゴールを選んでタイルを組み合わせよう"
	target_states.clear()
	for target_value in stage.targets:
		target_states.append({
			"value": target_value,
			"cleared": false,
		})
	changed.emit()


func select_target(index: int) -> void:
	if index < 0 or index >= target_states.size():
		return
	if target_states[index]["cleared"]:
		last_message = "クリア済みのゴールです"
		changed.emit()
		return
	selected_target_index = index
	clear_expression()
	last_message = "ゴール %s を選択中" % target_states[index]["value"]
	changed.emit()


func select_panel(panel) -> void:
	if panel.used:
		last_message = "そのタイルは使用済みです"
		changed.emit()
		return
	if _is_panel_in_expression(panel):
		last_message = "そのタイルはもう置いています"
		feedback.emit("bump")
		changed.emit()
		return
	if _is_current_target_cleared():
		last_message = "未クリアのゴールを選んでください"
		changed.emit()
		return
	if not _can_accept_panel(panel):
		last_message = _expected_input_message()
		changed.emit()
		return

	expression_panels.append(panel)
	sound_manager.play_tap()
	feedback.emit("tap")
	if expression_panels.size() == 3:
		_submit_expression()
	else:
		last_message = _expected_input_message()
		changed.emit()


func undo_expression() -> void:
	if expression_panels.is_empty():
		return
	expression_panels.pop_back()
	last_message = _expected_input_message()
	changed.emit()


func clear_expression() -> void:
	expression_panels.clear()
	last_message = _expected_input_message()
	changed.emit()


func revive_with_reward() -> bool:
	if remaining_mistakes > 0:
		last_message = "まだ復活は不要です"
		changed.emit()
		return false
	if not ad_manager.request_rewarded_revive():
		last_message = "このステージでは復活済みです"
		changed.emit()
		return false
	remaining_mistakes += 1
	clear_expression()
	last_message = "復活しました"
	changed.emit()
	return true


func get_current_expression_text() -> String:
	if expression_panels.is_empty():
		return ""
	var parts := PackedStringArray()
	for panel in expression_panels:
		parts.append(panel.display_text)
	return " ".join(parts)


func get_selected_target_value() -> Variant:
	if target_states.is_empty():
		return null
	return target_states[selected_target_index]["value"]


func can_revive() -> bool:
	return remaining_mistakes <= 0 and ad_manager.can_revive()


func _submit_expression() -> void:
	var left = expression_panels[0]
	var operator_panel = expression_panels[1]
	var right = expression_panels[2]
	var result := EXPRESSION_EVALUATOR_SCRIPT.evaluate(left.value, str(operator_panel.value), right.value)
	if not result["ok"]:
		_register_mistake(_message_for_reason(result["reason"]))
		return

	var target_value = get_selected_target_value()
	if EXPRESSION_EVALUATOR_SCRIPT.values_equal(result["value"], target_value):
		for panel in expression_panels:
			panel.used = true
		target_states[selected_target_index]["cleared"] = true
		combo_count += 1
		expression_panels.clear()
		sound_manager.play_correct()
		last_message = _combo_message(target_value)
		feedback.emit("clear" if _all_targets_cleared() else "correct")
		if _all_targets_cleared():
			sound_manager.play_clear()
			changed.emit()
			stage_cleared.emit()
			return
		_select_next_open_target()
		if _has_dead_end():
			last_message = "組み直したほうがよさそう"
			feedback.emit("bump")
		changed.emit()
	else:
		_register_mistake("計算が違います")


func _register_mistake(message: String) -> void:
	remaining_mistakes -= 1
	expression_panels.clear()
	combo_count = 0
	sound_manager.play_mistake()
	last_message = message
	feedback.emit("mistake")
	changed.emit()
	if remaining_mistakes <= 0:
		game_over.emit()


func _can_accept_panel(panel) -> bool:
	match expression_panels.size():
		0, 2:
			return panel.is_number()
		1:
			return panel.is_operator()
		_:
			return false


func _is_panel_in_expression(panel) -> bool:
	for expression_panel in expression_panels:
		if expression_panel.id == panel.id:
			return true
	return false


func _combo_message(target_value: Variant) -> String:
	if combo_count >= 3:
		return "%s連続! タイル配分がきれいです" % combo_count
	if combo_count >= 2:
		return "%s連続! いい流れです" % combo_count
	return "ゴール達成: %s" % target_value


func _has_dead_end() -> bool:
	for index in range(target_states.size()):
		if not target_states[index]["cleared"] and not _can_make_target(target_states[index]["value"]):
			return true
	return false


func _can_make_target(target_value: Variant) -> bool:
	var numbers: Array = []
	var operators: Array = []
	for panel in stage.panels:
		if panel.used:
			continue
		if panel.is_number():
			numbers.append(panel)
		elif panel.is_operator():
			operators.append(panel)

	for left in numbers:
		for right in numbers:
			if left.id == right.id:
				continue
			for operator_panel in operators:
				var result := EXPRESSION_EVALUATOR_SCRIPT.evaluate(left.value, str(operator_panel.value), right.value)
				if result["ok"] and EXPRESSION_EVALUATOR_SCRIPT.values_equal(result["value"], target_value):
					return true
	return false


func _expected_input_message() -> String:
	match expression_panels.size():
		0:
			return "数字タイルを選んでください"
		1:
			return "記号タイルを選んでください"
		2:
			return "もう1つ数字タイルを選んでください"
		_:
			return ""


func _message_for_reason(reason: String) -> String:
	match reason:
		EXPRESSION_EVALUATOR_SCRIPT.RESULT_DIVIDE_BY_ZERO:
			return "0で割れません"
		EXPRESSION_EVALUATOR_SCRIPT.RESULT_UNKNOWN_OPERATOR:
			return "演算子が不明です"
		_:
			return "組み合わせが成立していません"


func _is_current_target_cleared() -> bool:
	return not target_states.is_empty() and target_states[selected_target_index]["cleared"]


func _all_targets_cleared() -> bool:
	for target_state in target_states:
		if not target_state["cleared"]:
			return false
	return true


func _select_next_open_target() -> void:
	for index in range(target_states.size()):
		if not target_states[index]["cleared"]:
			selected_target_index = index
			return
