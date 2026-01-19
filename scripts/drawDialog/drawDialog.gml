function drawDialog(sprite, text) {
	// draw dialog box
	var gx = display_get_gui_width() * 0.5;
	var gy = display_get_gui_height() * 0.5;

	draw_sprite(sprite, 0, gx, gy);

	// text box boundaries
	var box_x1 = 10;
	var box_y1 = 137;
	var box_x2 = 414;
	var box_y2 = 210;

	var box_w = box_x2 - box_x1;
	var box_h = box_y2 - box_y1;

	// draw font
	draw_set_font(Font);
	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	draw_text_ext(
	    box_x1,
	    box_y1,
	    text,
	    -1,        // line separation
	    box_w     // wrap
	);
}