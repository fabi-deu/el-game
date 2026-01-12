// speeds for movement
hsp = 0;
vsp = 0;


// walking
walk_acceleration = 0.6;	// x += x*walk_acceleration
walk_max = 2.5;				// for clamping 
walk_friction = 0.7;		// x *= walk_friction for stopping slowly

// jumping
jump_height = -10;		// how high you jump
jump_cut = 0.4;				// jump release multiplier
gravity_up = 0.35;			// upwards movement sp
gravity_down = 0.6;			// downwards movement sp

// forgiveness timers in frame (make user feel better than reality = false happiness)
coyote_max = 6;				// allows for jumping after leaving the ledge
jump_buffer_max = 6;		// allows for jumping slightly before landing

coyote_timer = 0;
jump_buffer = 0;



// character states
on_ground = false;

// WALL JUMPS


move_and_collide(hsp, vsp, oBlock);
window_set_size(1920, 1080);