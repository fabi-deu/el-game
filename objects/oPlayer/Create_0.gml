// speeds for movement
hsp = 0;
vsp = 0;


// walking
walk_acceleration = 0.5;	// x += x*walk_acceleration
walk_max = 3;				// for clamping 
walk_friction = 0.6;		// x *= walk_friction for stopping slowly

// jumping
jump_height = -6;		// how high you jump
jump_cut = 0.4;				// jump release multiplier
gravity_up = 0.4;			// upwards movement sp
gravity_down = 0.2;			// downwards movement sp

// forgiveness timers in frame (make user feel better than reality = false happiness)
coyote_max = 6;				// allows for jumping after leaving the ledge
jump_buffer_max = 6;		// allows for jumping slightly before landing

coyote_timer = 0;
jump_buffer = 0;



// character states
enum PlayerState {
	IDLE,
	WALK,
	JUMP,
}
show_debug_message(image_speed);


state = PlayerState.IDLE
on_ground = false;
airborne = false;
facing = 1;


window_set_size(1920, 1080);


colliders = [layer_tilemap_get_id("dirt_tiles"), layer_tilemap_get_id("platform_tiles")];
