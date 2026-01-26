// check whether in dialog
if (!lock_step_event) return;

var _room_name = room_get_name(room);

// draw
var _sprite = dialogs[$_room_name][current_dialog].sprite;
var _text	= dialogs[$_room_name][current_dialog].text;

if (_text != "\\CANCEL_DIALOG") { // for making multiple dialogs possible
	drawDialog(_sprite, _text);
} else {
	current_dialog++;
	lock_step_event = false;
	return;
}

// for next dialog
if (keyboard_check_pressed(vk_left)) {
	current_dialog = clamp(--current_dialog, 0, array_length(dialogs[$_room_name]));
} else if (keyboard_check_pressed(vk_anykey)) {
	current_dialog++;
}


if (array_length(dialogs[$_room_name]) == current_dialog) {
	current_dialog = 0;
	lock_step_event = false;
}







