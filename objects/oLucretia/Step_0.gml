if (!instance_exists(oPlayer)) exit;

if ((oPlayer.x < x) && !passed_out) {
	image_xscale = -1
} else {
	image_xscale = 1
}