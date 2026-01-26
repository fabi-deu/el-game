
// for death animation
if (is_dead) {
	death_timer--;
	if (death_timer <= 0) { room_restart(); }
	image_index = death_index;
	return;
} else {
	death_index = image_index;
}

// for dialogs
if (lock_step_event) {
	if (place_empty(x, y + 1, colliders)) y++;
	image_xscale = facing;
	image_index = 0;
	return;
}


var move = keyboard_check(ord("D")) - keyboard_check(ord("A"));

// set facing of player for sprites
if (move != 0) facing = move;



// horizontal movement
if (move != 0) {
	hsp += move * walk_acceleration;
} else { // -> deaccel 
	hsp *= walk_friction;
}
hsp = clamp(hsp, -walk_max, walk_max);




// gravity
if (vsp < 0) {
	vsp += gravity_up;
} else {
	vsp += gravity_down;
}

// ground checks
on_ground = place_meeting(x, y + 1, colliders);
airborne = place_meeting(x, y + 2, colliders);

// one way platform collision
// check if player is falling and going to collide with platform
if (vsp > 0 && place_meeting(x , y + vsp, platform_tiles)) {
	if (!place_meeting(x, y, platform_tiles)) {
        while (!place_meeting(x, y + 1, platform_tiles)) {
            y += 1;
        }
        // act as ground
        vsp = 0;
        on_ground = true;
        // add platform to colliders
        if (!array_contains(colliders, platform_tiles)) {
            array_insert(colliders, 0, platform_tiles);
        }
    }
} else {
	// remove from colliders
	if (array_contains(colliders, platform_tiles)) {
		array_delete(colliders, 0, 1);
	}
} 


       
if (keyboard_check_pressed(vk_space)) {
	jump_buffer = jump_buffer_max;
}

if (on_ground) {
    coyote_timer = coyote_max;
} else {
    coyote_timer--;
}

// jump buffer and coyote timer
if (jump_buffer > 0) jump_buffer--;

if (jump_buffer > 0 && coyote_timer > 0) {
    vsp = jump_height;
    jump_buffer = 0;
    coyote_timer = 0;
}

// collision resolution
if (place_meeting(x + hsp, y, colliders)) {
    while (!place_meeting(x + sign(hsp), y, colliders)) {
        x += sign(hsp);
    }
    hsp = 0;
}
x += hsp;

if (place_meeting(x, y + vsp, colliders)) {
    while (!place_meeting(x, y + sign(vsp), colliders)) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;


// sprites
if (vsp != 0) {
    state = PlayerState.JUMP;
} else if (abs(hsp) <= 0.1 && vsp == 0) {
    state = PlayerState.IDLE;
} else if (abs(hsp) >= 0.1 && vsp == 0) {
    state = PlayerState.WALK;
}


// ! TODO: clean this mess up and use image_xscale
switch (state) {
	case PlayerState.IDLE:
		image_speed = 0.1;
		if (facing == -1) {
			// facing left -> idx 2-3
		    if (image_index < 2 || image_index >= 4) {
		        image_index = 2;
		    }
		} else {
			//facing right -> idx 0-1
		    if (image_index >= 2) {
		        image_index = 0;
		    }
		}
		break;
	case PlayerState.WALK:
		image_speed = 0.87;
		if (facing == -1) {
			// facing left -> idx 8-11
			if (image_index < 8 || image_index >= 11) {
				image_index = 8;
			}
		} else {
			//facing right -> idx 4-7
			if (image_index < 4 || image_index >= 7) {
				image_index = 4;
			}
		}
		
		break;
	case PlayerState.JUMP:
		image_speed = 1;
		if (facing == -1) {
			//facing left -> idx 18-21 + 22-23 landing
			if ( vsp < 0 ) {
				if ((image_index < 18 || image_index >= 20)) {
					image_index = 18;
				}
			} else if (vsp > 0 && airborne) {
				image_index = 21
			} else {
				image_speed = 0.1;
				if ((image_index < 22 || image_index >= 23)) {
					image_index = 22;
				}
			}
		
		
		
		} else {
			//facing right -> idx 12-15 + 16-17 landing
			if ( vsp < 0 ) {
				if ((image_index < 12 || image_index >= 15)) {
					image_index = 12;
				}
			} else if (vsp > 0 && airborne) {
				image_index = 15
			} else {
				image_speed = 0.67;
				if ((image_index < 16 || image_index >= 17)) {
					image_index = 16;
				}
			}
		}
		break;
}


