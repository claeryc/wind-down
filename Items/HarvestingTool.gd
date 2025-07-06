extends EquippableItem

class_name HarvestingTool

@export var effected_types  : Array[ResourceNodeType]
@export var min_amount : int = 1
@export var max_amount : int = 1

# if body is a resource node that matches with one of
# the effected_types, then the resource node will be
# harvested / freed / queue_freed, between the min/max
# damage amount of this tool
func interact_with_body(body):
	if(body is ResourceNode):
		for type in effected_types:
			if(body.node_types.has(type)):
				print_debug("Match found at "+type.display_name+" on "+body.name)
				body.harvest(randi_range(min_amount, max_amount))
				# $HarvestSound.play() # <- play sound
 
