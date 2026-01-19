// check whether in dialog
if (!lock_step_event) return;

var _room_name = room_get_name(room);

// draw
var _sprite =	dialogs[$_room_name][current_dialog].sprite;
var _text	=	dialogs[$_room_name][current_dialog].text;

drawDialog(_sprite, _text);


// for next dialog
if (keyboard_check_pressed(vk_space)) {
	current_dialog++;
}


if (array_length(dialogs[$_room_name]) == current_dialog) { 
	current_dialog = 0;
	lock_step_event = false;
}







