extends Node

func _init() -> void:
	var toml: String = FileAccess.get_file_as_string("res://sample.toml")
	var reader: TomlReader = TomlReader.new()
	reader.set_logging(true)
	var success: bool = reader.try_parse(toml)
	if not success:
		print("ERR: %s" % reader.get_last_error())
		return
	
	print("TOML parsed")
	
	
