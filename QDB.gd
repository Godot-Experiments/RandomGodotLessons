extends Node

var angles2 := {
	"π/2": PI / 2, 
	"π": PI,
	"3π/2": 3*PI/2,
	"2π": 2 * PI
	}
var angles : PoolRealArray = [4, 6]

var repr := {
	sqrt(2) / 2: "√2/2",
	sqrt(3) / 2: "√3/2",
	.5: "1/2",
	-sqrt(2) / 2: "-√2/2",
	-sqrt(3) / 2: "-√3/2",
	-.5: "-1/2"
}

# could possibly optimize by making values integers for faster comparisons, but may take more memory
# if want to store value: string map
var qa := {
	"6": "4 + 2", 
	"2": "1 + 1?"
}

#func _ready() -> void:
#	get_tree().get_root().set_transparent_background(true)
#	OS.window_per_pixel_transparency_enabled = true


#	for i in range(10):
#		choose_angle()


func choose_angle():
	randomize()
	var denom := angles[randi() % 2]
	var numer := randi() % (int(denom) * 2)

	if numer % 2 == 0:
			denom /= 2
			numer /= 2
	elif numer % 3 == 0 and int(denom) % 3 == 0:
		denom /= 3
		numer /= 3
	var frac : float = numer / denom
	if numer == 0:
		print("cos(0) = _?")
	elif numer == 1:
		print("cos(π/" + str(denom) + ") = _?")
	else:
		print("cos(" + str(numer) + "π/" + str(denom) + ") = _?")
	var answer : String
	frac *= PI
	frac = cos(frac)
	if frac in repr:
		answer = repr[frac]
		print("SLDFJ")
	else:
		answer = str(frac)
	print("ANswer: ", frac, " ", answer)
	print(" ")

