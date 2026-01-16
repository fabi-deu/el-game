if (instance_exists(oPlayer)) {
	camera_set_view_pos(camera, x, y)
	x = lerp(x, oPlayer.x, 0.075);
	y = lerp(y, oPlayer.y + 32, 0.075);
} else {
	show_error("Failed to find player object for setting position of camera", false);
}