extends CanvasLayer

@onready var player=$"../Player"
@onready var heart=$heart
@onready var outline=$heart_out
	
func _ready():
	for i in range(player.health):
		var health_node = heart.duplicate()
		health_node.set_visible(true)
		health_node.position.x+=40*i
		health_node.set_name("heart_%d" % i)
		add_child(health_node)
		var heart_out=outline.duplicate()
		heart_out.set_visible(true)
		heart_out = heart_out.duplicate()
		heart_out.position.x+=40*i
		add_child(heart_out)
