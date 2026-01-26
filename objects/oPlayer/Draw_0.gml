// death animation
if (is_dead && (current_time div 100) mod 2 == 0) {
	draw_sprite_ext(
		sprite_index,
		image_index,
		x,
		y,
		image_xscale,
		image_yscale,
		image_angle,
		c_red,
		image_alpha
	);
} else
{
	draw_self();
}