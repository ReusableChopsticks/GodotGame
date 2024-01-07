extends CanvasLayer

@export var grade_sprite: Sprite2D
@export var stats: PlayerStats
@onready var anim: AnimationPlayer = $AnimationPlayer
#@onready var time_label = $MarginContainer/HBoxContainer/StatsContainer/TimeLabel

var shuffle_frequency: float = 0.1

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

func on_game_over(cause):
	visible = true
	$MarginContainer/HBoxContainer/StatsContainer/TimeLabel.text += "%.2f" % stats.total_time
	$MarginContainer/HBoxContainer/StatsContainer/EatenLabel.text += str(stats.lunch_eaten) + "%"
	anim.play("show_grade")

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


