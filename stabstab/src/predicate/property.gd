@tool
extends Node
class_name PropertyPredicate

const BEHAVIOUR: String = "behaviour"
const PREDICATE: String = "predicate"

const SUBJECT_TYPE_NAME: String = BEHAVIOUR + "/" + PREDICATE + "/" + "subject_type"
const COMPARISON_NAME: String = BEHAVIOUR + "/" + PREDICATE + "/" + "comparison"
const PROPERTY_NAME_NAME: String = BEHAVIOUR + "/" + PREDICATE + "/" + "property_name"
const COMPARATOR_NAME: String = BEHAVIOUR + "/" + PREDICATE + "/" + "comparator"

var _exposed_properties: Dictionary

var _comparisons: Array[Callable] = [
	func(a, b): return a == b, # equals
	func(a, b): return a != b, # not equals
	func(a, b): return a < b, # less
	func(a, b): return a <= b, # less equals
	func(a, b): return a > b, # greater
	func(a, b): return a >= b, # greater equals
]

######## Exported Variables ##########

func test(subject: Node) -> bool:
	var property_name = _get(PROPERTY_NAME_NAME)
	if property_name == null: return false

	var comparator_idx = _get(COMPARATOR_NAME)
	if comparator_idx == null: return false

	if not subject.has_meta(property_name):
		push_error("%s has no property named %s" % [subject, property_name])
		return false

	return _comparisons[comparator_idx].call(subject.get_meta(property_name), comparator_idx)

########### Overrides ###########

func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = [
		{
			name = SUBJECT_TYPE_NAME,
			type = TYPE_STRING,
			hint = PROPERTY_HINT_TYPE_STRING,
			hint_string = "Node",
		},
		{
			name = COMPARISON_NAME,
			type = TYPE_INT,
			hint = PROPERTY_HINT_ENUM,
			hint_string = "equals,not_equals,less,less_equals,greater,greater_equals",
		},
	]

	var subject_type = _get(SUBJECT_TYPE_NAME)
	if subject_type == null: return properties

	var property_list = _get_property_list_from_class(subject_type)
	properties.append(_define_property_list_property(property_list))

	var property_name = _get(PROPERTY_NAME_NAME)
	if property_name == null: return properties

	var comparator = _define_comparator_property(property_name, property_list)
	if comparator.is_empty(): return properties

	properties.append(comparator)
	
	return properties

func _set(property: StringName, val) -> bool:
	_exposed_properties[property] = val
	notify_property_list_changed()
	return true

func _get(property: StringName): return _exposed_properties.get(property, )

############# Internal functions #############

func _define_property_list_property(properties: Array[Dictionary]) -> Dictionary:
	var property_list = properties.map(func(prop: Dictionary): return prop.name)
	return {
		name = PROPERTY_NAME_NAME,
		type = TYPE_STRING,
		hint = PROPERTY_HINT_ENUM,
		hint_string = ",".join(property_list),
	}

func _get_property_list_from_class(cname: StringName) -> Array[Dictionary]:
	if cname == null: return []
	
	var property_list: Array[Dictionary] = []
	var script_properties = ClassDB.class_get_property_list(cname)
	for prop in script_properties:
		property_list.append(prop)

	return property_list

func _define_comparator_property(property_name: StringName, properties: Array[Dictionary]) -> Dictionary:
	if property_name.is_empty() or not properties.any(func(prop: Dictionary): return prop.name == property_name): return {}

	for prop in properties:
		if prop.name == property_name: return {
			name = COMPARATOR_NAME,
			type = prop.type,
			hint = prop.hint,
			hint_string = prop.hint_string
		}
	
	return {}
