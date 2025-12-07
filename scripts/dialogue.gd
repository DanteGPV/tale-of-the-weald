extends CanvasLayer

@export_file("*.json") var DIALOGUE_FILE : String

var dialogues = []
var currentDialogueID : String = "404"
var isDialogueActive = false
var player

func _ready():
	var root = get_tree().get_root()
	player = root.get_node("Main/PlayerCharacter")
	$Control.visible = false

func play_from(startID):
	dialogues = load_dialogue()
	currentDialogueID = startID
	$Control/Box/Name.text = dialogues[currentDialogueID]["character"]
	$Control/Box/Text.text = dialogues[currentDialogueID]["text"]
	$Control.visible = true
	isDialogueActive = true
	if player:
		player.set_active(false)

func _input(event):
	if Input.is_action_just_pressed("jump") and isDialogueActive and $DialogueCooldownTimer.is_stopped():
		advance_dialogue()
	return

func advance_dialogue():
	if (dialogues[currentDialogueID].has("function") and dialogues[currentDialogueID]["function"] == "end_dialogue"):
		end_dialogue()
		return
	currentDialogueID = dialogues[currentDialogueID]["go to"]
	$Control/Box/Name.text = dialogues[currentDialogueID]["character"]
	$Control/Box/Text.text = dialogues[currentDialogueID]["text"]
	return


func load_dialogue():
	var file = JSON.new()
	var parseResult = file.parse(FileAccess.get_file_as_string(DIALOGUE_FILE))
	if parseResult != OK:
		var errorLine = file.get_error_line()
		var errorMessage = file.get_error_message()
		print("ERROR %s READING JSON FILE" % parseResult)
		print("ERROR AT %s" % errorLine)
		print("ERROR MESSAGE %s" % errorMessage)
	var content = file.get_data()
	return content

func end_dialogue():
	$Control.visible = false
	if player:
		player.set_active(true)
	$DialogueCooldownTimer.start()
	return


func _on_dialogue_cooldown_timer_timeout():
	isDialogueActive = false
