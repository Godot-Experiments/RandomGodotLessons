extends Node

# Load files of extension EXT from DIR and return it as an array of loaded resources
static func load_files(dir: String, ext: String = ".png") -> Array:
	var files: Array = []
	var filenames: Array = []
	var file_directory: Directory = Directory.new()
	if file_directory.open(dir) == OK:
		if file_directory.list_dir_begin(true) == OK:
			var file: String = file_directory.get_next()
			while file != "":
				if file.right(file.length() - ext.length()) == ext:
					filenames.append(dir + "/" + file)
	#				filenames.append("preload(\"" + dir + file + "\")")
				file = file_directory.get_next()
			file_directory.list_dir_end()
		else:
			print("ERROR: Couldn't load " + ext + " files!")
	for file in filenames:
		files.append(load(file))
	return files
