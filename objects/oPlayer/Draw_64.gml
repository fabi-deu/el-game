// check whether in dialog
if (!lock_step_event) return;

var _room_name = room_get_name(room);

// draw
var _sprite = dialogs[$_room_name][current_dialog].sprite;
var _text	= dialogs[$_room_name][current_dialog].text;


switch (_text) {
	case "\\LUCRETIA_PASSING_OUT":	// last level
		oLucretia.pass_out();
		current_dialog++;
		return;
	case "\\LUCRETIA_WAKE_UP":		// last level
		oLucretia.wake_up();
		current_dialog++;
		return;
	case "\\CANCEL_DIALOG":			// probally not going to use
		current_dialog++;
		lock_step_event = false;
		return;
	default:
		drawDialog(_sprite, _text);	//
}


// for next dialog
if (keyboard_check_pressed(vk_left)) {
	current_dialog = clamp(--current_dialog, 0, array_length(dialogs[$_room_name]));
} else if (keyboard_check_pressed(vk_anykey)) {
	current_dialog++;
}

// end of dialog
if (array_length(dialogs[$_room_name]) == current_dialog) {
	current_dialog = 0;
	lock_step_event = false;
}







