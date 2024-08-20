extends Node2D

@onready var planet1 = $planet1
@onready var planet2 = $planet2
@onready var planet3 = $planet3
@onready var planet4 = $planet4
@onready var planet5 = $planet5
@onready var planet6 = $planet6
@onready var planet7 = $planet7
@onready var planet8 = $planet8
@onready var planet9 = $planet9
@onready var planet10 = $planet10

func _physics_process(delta):
		planet1.rotation = planet1.rotation + deg_to_rad(float(27)) * delta
		planet2.rotation = planet2.rotation + deg_to_rad(float(24)) * delta
		planet3.rotation = planet3.rotation + deg_to_rad(float(21)) * delta
		planet4.rotation = planet4.rotation + deg_to_rad(float(18)) * delta
		planet5.rotation = planet5.rotation + deg_to_rad(float(15)) * delta
		planet6.rotation = planet6.rotation + deg_to_rad(float(12)) * delta
		planet7.rotation = planet7.rotation + deg_to_rad(float(9)) * delta
		planet8.rotation = planet8.rotation + deg_to_rad(float(6)) * delta
		planet9.rotation = planet9.rotation + deg_to_rad(float(3)) * delta
		planet10.rotation = planet10.rotation + deg_to_rad(float(1)) * delta
