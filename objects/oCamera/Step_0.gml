if (instance_exists(oPlayer)) {
	x = lerp(x, oPlayer.x+75, 0.075);
	y = lerp(y, oPlayer.y+8, 0.075);
} else {
	show_error("Failed to find player object for setting position of camera", false);
}