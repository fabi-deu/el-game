var move = keyboard_check(ord("D")) - keyboard_check(ord("A"));

// horizontal movement
if (move != 0) {
	hsp += move * walk_acceleration;
} else { // -> deaccel 
	hsp *= walk_friction;
}

hsp = clamp(hsp, -walk_max, walk_max);


// vertical movement
if (keyboard_check_pressed(vk_space)) {
	jump_buffer = jump_buffer_max;
}

// gravity
if (vsp < 0) {
	vsp += gravity_up;
} else {
	vsp += gravity_down;
}

// ground checks
on_ground = place_meeting(x, y + 1, colliders);

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

