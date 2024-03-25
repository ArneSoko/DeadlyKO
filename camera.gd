extends Node3D

@onready var pitch=$CamPitch
@onready var arm=$CamPitch/CamArm

var sensitivity = 0.5

func _input(_event):
	#Change view distance
	if Input.is_action_pressed("Zoom_In") and arm.spring_length > 0:
		arm.spring_length -= 0.2
	elif Input.is_action_pressed("Zoom_Out"):
		arm.spring_length += 0.2

