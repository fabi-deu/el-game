// moving left -> -1 moving both -> 0 moving right -> 1
var move = keyboard_check(vk_right) - keyboard_check(vk_left);

// h-movement
if (move != 0) {
	hsp += move * walk_acceleration;
} else {
	hsp *= walk_friction;
}

// gravity
if (vsp < 0) {
	vsp += gravity_up;
} else {
	vsp += gravity_down;
}


// ground checks
on_ground = place_meeting(x, y+1, oBlock);


// forgiveness buffers
 // coyote
if (on_ground) {
	coyote_timer = coyote_max;
} else {
	coyote_timer--;
}

 // jump
if (keyboard_check_pressed(vk_space)) {
	jump_buffer = jump_buffer_max;
}

if (jump_buffer > 0) jump_buffer--;

if (jump_buffer > 0 && coyote_timer > 0) {
	vsp = jump_height;
	jump_buffer = 0;
	coyote_timer = 0;
}

// variable jump height
if (keyboard_check_released(vk_space) && vsp < 0) {
	vsp *= jump_cut;

}

/*
// corner correction 
if (vsp > 0 && !on_ground) {
	for (var i = 1; i <= 4; i++) {
		// not enough
		if (!place_meeting(x+i, y+vsp, oBlock)) {
			x += i;
			break;
		}
		
		// too far
		if (!place_meeting(x-i, y+vsp, oBlock)) {
			x -= i;
			break;
		}
	}
}
*/


// collisions
 // horizontal
if (place_meeting(x + hsp, y, oBlock)) {
    while (!place_meeting(x + sign(hsp), y, oBlock)) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;
 
 // vertical
if (place_meeting(x, y + vsp, oBlock)) {
    while (!place_meeting(x, y + sign(vsp), oBlock)) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;