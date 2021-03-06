extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var singleton

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("on_request_permissions_result", self, "result")
	if(OS.request_permissions()):
		result("", true)
	pass # Replace with function body.

func result(permission, granted):
	if granted:
		if Engine.has_singleton("LocationPlugin"):
			singleton = Engine.get_singleton("LocationPlugin")
			singleton.connect("onLocationUpdates", self , "gotLocationUpdate")
			singleton.connect("onLastKnownLocation", self , "gotLastKnown")
			singleton.connect("onLocationError", self , "gotError")
			singleton.startLocationUpdates(6000, 10000)

func gotLocationUpdate(locData):
	updateUserInterface(locData)
	pass
	
func gotLastKnown(locData):
	updateUserInterface(locData)
	pass

func gotError(error, message):
	pass
	
func updateUserInterface(locData):
	$Values/longitudeValue.text = str(locData.longitude)
	$Values/latitudeValue.text = str(locData.latitude)
	$Values/accuracyValue.text = str(locData.accuracy)
	$Values/verticalAccuracyMetersValue.text = str(locData.verticalAccuracyMeters)
	$Values/altitudeValue.text = str(locData.altitude)
	$Values/speedValue.text = str(locData.speed)
	$Values/TimeValue.text = str(locData.time)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_button_down():
	singleton.getLastKnowLocation()
	pass # Replace with function body.
