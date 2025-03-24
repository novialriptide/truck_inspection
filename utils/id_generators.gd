class_name IdentificationGenerators

static var _lower_characters = 'abcdefghijklmnopqrstuvwxyz'
static var _upper_characters = _lower_characters.to_upper()

static func _generate_string(chars, length):
	var value: String
	var n_char = len(chars)
	for i in range(length):
		value += chars[randi()% n_char]
	return value

static func new_license_plate():
	var value = "%a-%b"
	return value.format({
		"a": _generate_string(_upper_characters, 3),
		"b": _generate_string(_upper_characters, 3),
	})

static func new_truck_id():
	return _generate_string(_upper_characters, 10)
