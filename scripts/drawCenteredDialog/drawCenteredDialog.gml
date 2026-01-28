function drawCenteredDialog(text) {
	// center of viewport
	var cx = display_get_gui_width() * 0.5;
	var cy = display_get_gui_height() * 0.5;


	// for wrapping
	var wrap_w = display_get_gui_width() * 0.8;

	draw_set_font(Font);
	draw_set_colour(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);


	var text_h = string_height_ext(text, -1, wrap_w);
	var text_y = cy - text_h * 0.5;


	// draw text
	draw_text_ext(
		cx,
		text_y,
		text,
		-1,
		wrap_w
	);
}