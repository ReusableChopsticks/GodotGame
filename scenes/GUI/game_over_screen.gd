extends CanvasLayer

@export var grade_sprite: Sprite2D
@export var stats: PlayerStats
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var time_label = $MarginContainer/HBoxContainer/StatsContainer/TimeLabel
@onready var eaten_label = $MarginContainer/HBoxContainer/StatsContainer/EatenLabel
@onready var pidgeon_label = $MarginContainer/HBoxContainer/StatsContainer/PidgeonLabel
@onready var seagull_label = $MarginContainer/HBoxContainer/StatsContainer/SeagullLabel
@onready var child_label = $MarginContainer/HBoxContainer/StatsContainer/ChildLabel
@export var album: Album

@onready var shuffle_noise = $Audio/shuffle_grade
@onready var show_noise = $Audio/show_grade

var shuffle_frequency: float = 0.1
@onready var time_text = time_label.text
@onready var eaten_text = eaten_label.text
var time = 0.0
var refresh = 0.0

# dictionary of threshholds for each grade
var grades = {
	"S": 90,
	"A": 80,
	"B": 70,
	"C": 60,
	"D": 50
}

# Called when the node enters the scene tree for the first time.
func _ready():
	#visible = false
	GlobalSignals.game_over.connect(on_game_over)
	time_text = time_label.text
	eaten_text = eaten_label.text
	time_label.text += "----"
	eaten_label.text += "----"
	grade_sprite.visible = false
	
	pidgeon_label.visible = false
	seagull_label.visible = false
	child_label.visible = false

# This is the most disgusting way to animate the text
# but i couldn't find a better way
# so this is just to show what i wanted to achieve
var first_time = false
var first_eaten = false
var game_over = false
func _process(delta):
	if game_over:
		time += delta
		refresh += delta
		if refresh > 0.05 and time < 2:
			refresh = 0
			shuffle_noise.play()
			if time < 1:
				time_label.text = time_text + ("%.2f" % rand_nums()) + "s"
			elif time < 2:
				eaten_label.text = eaten_text + str("%.f" %rand_nums()) + "%"
		
		if time > 1 and not first_time:
			time_label.text = time_text + "%.2f" % stats.total_time
			first_time = true
			show_noise.play()
		elif time > 2 and not first_eaten:
			eaten_label.text = eaten_text + str(stats.lunch_eaten) + "%"
			first_eaten = true
			show_noise.play()

func on_game_over():
	pass

func show_letter_grade():
	# this works only for the specific sprite sheet i found
	# update later when revamping graphics
	var eaten = stats.lunch_eaten
	if eaten >= grades.S:
		grade_sprite.frame = 0
	elif eaten >= grades.A:
		grade_sprite.frame = 1
	elif eaten >= grades.B:
		grade_sprite.frame = 3
	elif eaten >= grades.C:
		grade_sprite.frame = 5
	elif eaten >= grades.D:
		grade_sprite.frame = 6
	else:
		grade_sprite.frame = 8

func rand_nums() -> float:
	return randf_range(0, 500)
	


func _on_level_base_show_game_over_screen():
	visible = true
	game_over = true
	#$MarginContainer/HBoxContainer/StatsContainer/TimeLabel.text += "%.2f" % stats.total_time
	#$MarginContainer/HBoxContainer/StatsContainer/EatenLabel.text += str(stats.lunch_eaten) + "%"
	await get_tree().create_timer(2).timeout
	grade_sprite.visible = true
	anim.play("show_grade")
	await get_tree().create_timer(1.5).timeout
	var pidgeon_count = 0
	var seagull_count = 0
	var child_count = 0
	for bird in album.album.keys():
		print(bird.name.substr(0,3))
		if bird.name.substr(0,3) == "Pig": #cant believe i have to admit im naming them wrong
			pidgeon_count += 1
		if bird.name.substr(0,3) == "Sea":
			seagull_count += 1
		if bird.name.substr(0,3) == "Chi":
			child_count += 1
			
	pidgeon_label.text += str(pidgeon_count)
	pidgeon_label.visible = true
	await get_tree().create_timer(0.3).timeout
	seagull_label.text += str(seagull_count)
	seagull_label.visible = true
	await get_tree().create_timer(0.3).timeout
	child_label.text += str(child_count)
	child_label.visible = true
