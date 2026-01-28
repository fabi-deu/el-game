passed_out = false;

function pass_out() {
	// slow animation
	image_angle = 270;
	
	passed_out = true;
}


function wake_up() {
	image_angle = 0;
	
	passed_out = false;
}