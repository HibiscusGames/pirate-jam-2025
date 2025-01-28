class_name Option

var _value: Variant;

static func Some(v: Variant) -> Option:
	var opt = Option.new()
	opt._value = v
	return opt

static func None() -> Option:
	return Option.new()

func is_some() -> bool:
	return _value != null

func is_none() -> bool:
	return _value == null

func get_or(on_none: Callable) -> Variant:
	if is_some():
		return _value
	else:
		return on_none.call()

