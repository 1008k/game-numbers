class_name ExpressionEvaluator
extends RefCounted

const RESULT_OK := "ok"
const RESULT_INCOMPLETE := "incomplete"
const RESULT_DIVIDE_BY_ZERO := "divide_by_zero"
const RESULT_UNKNOWN_OPERATOR := "unknown_operator"


static func evaluate(left: Variant, operator_text: String, right: Variant) -> Dictionary:
	if left == null or operator_text == "" or right == null:
		return {
			"ok": false,
			"reason": RESULT_INCOMPLETE,
			"value": null,
		}

	var left_number := float(left)
	var right_number := float(right)

	match operator_text:
		"+":
			return _ok(left_number + right_number)
		"-":
			return _ok(left_number - right_number)
		"×", "*":
			return _ok(left_number * right_number)
		"÷", "/":
			if is_zero(right_number):
				return {
					"ok": false,
					"reason": RESULT_DIVIDE_BY_ZERO,
					"value": null,
				}
			return _ok(left_number / right_number)
		_:
			return {
				"ok": false,
				"reason": RESULT_UNKNOWN_OPERATOR,
				"value": null,
			}


static func values_equal(left: Variant, right: Variant) -> bool:
	return abs(float(left) - float(right)) < 0.00001


static func is_zero(value: float) -> bool:
	return abs(value) < 0.00001


static func _ok(value: float) -> Dictionary:
	return {
		"ok": true,
		"reason": RESULT_OK,
		"value": value,
	}

