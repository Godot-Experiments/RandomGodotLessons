extends Node2D

var msgs : PoolStringArray = [
	"""Ruhi - I raytraced a bunny for my project, which perfectly fit. 
	'Nuff said, can't think of a better matching.""",
	
	"""
	ShekShek - Duh, what else? Not only is he an absolute monkey ape, 
	he would be too lazy to actually get out of bed to show up in the image,
	 so only his banana would be left in the frame. However, he's also our golden boy, 
	reflecting the semi-goldish of this image, 	full of laughs and good nature even 
	as we poke fun at him :3 """,
	
	"""
	Kristy - So the other day I learned that gai dan, which means chicken egg literally,
	figuratively means egghead from my canto grandma (yes I know you're mando). 
	Very random thought, which idk I think characterizes Krispy? Randomness and sporadicness, 
	idk its been a while since we talked, also 
	a r t i s t i c   e g g """,
	
	"""
	Nabeel - Bc he comes from an island nobody knows of, like what??? Who is she??? 
	(I still don't know what that references lol)
	But also the island is super beautiful, like it came out from the heavens
	 - just like his beautiful, laid back nature and unexpected but very funny jokes and perfectly gelled hair.
	(yes I am once again asking for your support in tolerating me making a nabeel hair joke for the 42nd time) 
	""",
	
	"""
	Emily - bc I dont know enough to see through your  surface. I've heard you're a good roaster 
	(hence \"lighthouse\" -> \"sun\" -> \"roast\", and rn its rotated where I can't see the light) 
	But the light isn't just for roasting, I have a feeling you're hiding some heavenly stuff in 
	that lighthouse of yours, like I heard you have talents I never would've guessed, like dancing 
	and painting. Idk hopefully I'll get to know ya better
	""",
	
	"""
	Negin - Whenever i think of you, i always remember your cardigan/scarf/shawl/idk what its called, 
	kinda like how the dragon's scales are always on the dragon. 
	Also, dragon bc of the no nonsense attitude, spirited. 
	But now I got a weird image of a dragon molting if I imagine you takes it off, 
	though I can't remember a time when that's happened. Hopefully I'll get to see more of this hidden 
	dragon as well (movie title pun ha), because I think we can agree Dragons, although fierce, are fire 
	(breathing, aha there's another pun)
	""",
	
	"""
	Samhita - So you got the nice, perfectly realisticly rendered room (this is not a real room) 
	because her aesthetic is always on point, and its always a lovely time talking with her. 
	There's also curry cuz she always got that spice that everyone loves ya know? Just the 
	right amount, no goldilocks too much too little, (except maybe ruhi who cant handle spice) 
	Very flavorful, and a most cursed thought popped in my head \"I'd eat that anyday\" - don't tell 
	kevin and plz dont kill me
	"""
	
	
]

var ppl : PoolStringArray = [
	"ruh",
	"ab",
	"kri",
	"nab",
	"em",
	"neg",
	"sam"
]

var hidden_ppl : PoolStringArray = [
	"em",
	"neg"
]


var imgs := {}

const img_dir := "img/"
export (PackedScene) var exhibit_s


func _ready() -> void:
	var pos := Vector2(0, -500)
	for p in ppl:
		var exh : Exhibit = exhibit_s.instance()
		exh.position = pos
		exh.name = p
		add_child(exh)
		pos.x += 5000
	
	for p in ppl:
		if get_node_or_null(p):
			for img in G.load_files(img_dir + p, "jpg"):
				var texture := TextureRect.new()
				texture.texture = img
				get_node(p).add(texture)
			for img in G.load_files(img_dir + p, "png"):
				var texture := TextureRect.new()
				texture.texture = img
				get_node(p).add(texture)
	
	for p in ppl:
		if get_node_or_null(p):
			for img in G.load_files(img_dir + p + "_h", "jpg"):
				var texture := TextureRect.new()
				texture.texture = img
				get_node(p).add_hidden(texture)
			for img in G.load_files(img_dir + p + "_h", "png"):
				var texture := TextureRect.new()
				texture.texture = img
				get_node(p).add_hidden(texture)
				
	var i := 0
	for child in get_children():
		child.set_txt(msgs[i])
		i += 1


func _on_Timer_timeout():
	var i := 0
	for child in get_children():
		print(msgs)
		child.call_deferred("set_txt", msgs[i])
		i += 1
