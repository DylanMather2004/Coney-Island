class_name Character 
extends CharacterBody2D

@export var max_health=100
var health
@export var damage = 10
@export var move_speed:float 
func _ready():
	health=max_health
#Adds the change argument to the health variable, then clamps health
func Change_Health(change):
	health += change
	health = clampi(health,0,max_health)
	
