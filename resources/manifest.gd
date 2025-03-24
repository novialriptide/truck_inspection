class_name Manifest extends Resource

@export var identification: String;
@export var company_id: String;
@export var members: Array[CrewMember];
@export var manifest_expires: String;

func _init():
	identification = IdentificationGenerators.new_truck_id()
	company_id = "PLACEHOLDER"
	members = []
