extends Node

## C:%HOMEPATH%\AppData\Roaming\Godot\app_userdata\your_project_name

func _input(event: InputEvent) -> void:
	if OS.is_debug_build() and event.is_action_pressed("screenshot"):
		var date_time = Time.get_datetime_dict_from_system()
		var file_name = "%04d-%02d-%02d_%02d-%02d-%02d.png" % [
			date_time.year, date_time.month, date_time.day,
			date_time.hour, date_time.minute, date_time.second
		]
		var project_name = ProjectSettings.get_setting(
			"application/config/name"
			)
		var project_version = ProjectSettings.get_setting(
			"application/config/version"
			)
		if typeof(project_version) != TYPE_STRING or project_version.strip_edges() == "":
			project_version = "0.0.0"
		var screenshot_dir = "user://screenshots/"
		var full_file_name = "%s_%s_%s" % [project_name, project_version, file_name]
		var screenshot_path = screenshot_dir + full_file_name
		var dir = DirAccess.open("user://")
		if not dir.dir_exists("screenshots"):
			dir.make_dir("screenshots")
		var image = get_viewport().get_texture().get_image()
		var error = image.save_png(screenshot_path)
		if error == OK:
			print("Screenshot saved to: ", screenshot_path)
		else:
			print("Failed to save screenshot. Error code: ", error)
