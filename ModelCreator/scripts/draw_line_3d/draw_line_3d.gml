/// @function draw_line_3d(x1, y1, z1, x2, y2, z2, color, alpha);

/// @param x1
/// @param y1
/// @param z1
/// @param x2
/// @param y2
/// @param z2
/// @param color
/// @param alpha

function draw_line_3d(x1, y1, z1, x2, y2, z2, color, alpha){
	// Convert the color in its rgb values
	var int_r = color_get_red(color);
	var int_g = color_get_green(color);
	var int_b = color_get_blue(color);
	// Make the alpha value into an 8-bit integer (0 - 255)
	var int_a = 255 * alpha;
	
	var line_buffer = buffer_create(72, buffer_fixed, 1);
	
	// First vertex point position (the "from"-coord)
	buffer_write(line_buffer, buffer_f32, x1);
	buffer_write(line_buffer, buffer_f32, y1);
	buffer_write(line_buffer, buffer_f32, z1);
	
	// Normal vector (not important for a line though)
	buffer_write(line_buffer, buffer_s32, 0);
	buffer_write(line_buffer, buffer_s32, 0);
	buffer_write(line_buffer, buffer_s32, 0);
	
	// Texcoord (not important too)
	buffer_write(line_buffer, buffer_u32, 0);
	buffer_write(line_buffer, buffer_u32, 0);
	
	// Color values and alpha value (r, g, b, a)
	buffer_write(line_buffer, buffer_u8, int_r);
	buffer_write(line_buffer, buffer_u8, int_g);
	buffer_write(line_buffer, buffer_u8, int_b);
	buffer_write(line_buffer, buffer_u8, int_a);
	
	// Second vertex point position (the "to"-coord)
	buffer_write(line_buffer, buffer_f32, x2);
	buffer_write(line_buffer, buffer_f32, y2);
	buffer_write(line_buffer, buffer_f32, z2);
	
	// Normal vector (not important for a line though)
	buffer_write(line_buffer, buffer_s32, 0);
	buffer_write(line_buffer, buffer_s32, 0);
	buffer_write(line_buffer, buffer_s32, 0);
	
	// Texcoord (not important too)
	buffer_write(line_buffer, buffer_u32, 0);
	buffer_write(line_buffer, buffer_u32, 0);
	
	// Color values and alpha value (r, g, b, a)
	buffer_write(line_buffer, buffer_u8, int_r);
	buffer_write(line_buffer, buffer_u8, int_g);
	buffer_write(line_buffer, buffer_u8, int_b);
	buffer_write(line_buffer, buffer_u8, int_a);
	
	var vertex_line = vertex_create_buffer_from_buffer(line_buffer, o_softwareManager.vformat);
	buffer_delete(line_buffer);
	
	return vertex_line;
}
	
/// @function create_grid(start_x, start_y, start_z, cell_size, width, height, color, alpha);

/// @param start_x
/// @param start_y
/// @param start_z
/// @param cell_size
/// @param width
/// @param height
/// @param color
/// @param alpha

function create_grid(start_x, start_y, start_z, cell_size, width, height, color, alpha){
	// Convert the color in its rgb values
	var int_r = color_get_red(color);
	var int_g = color_get_green(color);
	var int_b = color_get_blue(color);
	// Make the alpha value into an 8-bit integer (0 - 255)
	var int_a = 255 * alpha;
	
	var grid_h_amount_lines = floor(width / cell_size);
	var grid_v_amount_lines = floor(height / cell_size);
	
	var grid_buffer = buffer_create(72 * (grid_h_amount_lines + grid_v_amount_lines + 2), buffer_fixed, 1);
	
	// Write every horizontal line to the buffer
	for (var i = 0; i <= grid_h_amount_lines; i++) {
		var x1 = start_x;
		var y1 = start_y + (cell_size * i);
		var z1 = start_z;
		
		var x2 = start_x + width;
		var y2 = start_y + (cell_size * i);
		var z2 = start_z;
		
		// First vertex point position (the "from"-coord)
		buffer_write(grid_buffer, buffer_f32, x1);
		buffer_write(grid_buffer, buffer_f32, y1);
		buffer_write(grid_buffer, buffer_f32, z1);
	
		// Normal vector (not important for a line though)
		buffer_write(grid_buffer, buffer_s32, 0);
		buffer_write(grid_buffer, buffer_s32, 0);
		buffer_write(grid_buffer, buffer_s32, 0);
	
		// Texcoord (not important too)
		buffer_write(grid_buffer, buffer_u32, 0);
		buffer_write(grid_buffer, buffer_u32, 0);
	
		// Color values and alpha value (r, g, b, a)
		buffer_write(grid_buffer, buffer_u8, int_r);
		buffer_write(grid_buffer, buffer_u8, int_g);
		buffer_write(grid_buffer, buffer_u8, int_b);
		buffer_write(grid_buffer, buffer_u8, int_a);
	
		// Second vertex point position (the "to"-coord)
		buffer_write(grid_buffer, buffer_f32, x2);
		buffer_write(grid_buffer, buffer_f32, y2);
		buffer_write(grid_buffer, buffer_f32, z2);
	
		// Normal vector (not important for a line though)
		buffer_write(grid_buffer, buffer_s32, 0);
		buffer_write(grid_buffer, buffer_s32, 0);
		buffer_write(grid_buffer, buffer_s32, 0);
	
		// Texcoord (not important too)
		buffer_write(grid_buffer, buffer_u32, 0);
		buffer_write(grid_buffer, buffer_u32, 0);
	
		// Color values and alpha value (r, g, b, a)
		buffer_write(grid_buffer, buffer_u8, int_r);
		buffer_write(grid_buffer, buffer_u8, int_g);
		buffer_write(grid_buffer, buffer_u8, int_b);
		buffer_write(grid_buffer, buffer_u8, int_a);
	}
	// Write every vertical line to the buffer
	for (var j = 0; j <= grid_v_amount_lines; j++) {
		var x1 = start_x + (cell_size * j);
		var y1 = start_y;
		var z1 = start_z;
		
		var x2 = start_x + (cell_size * j);
		var y2 = start_y + height;
		var z2 = start_z;
		
		// First vertex point position (the "from"-coord)
		buffer_write(grid_buffer, buffer_f32, x1);
		buffer_write(grid_buffer, buffer_f32, y1);
		buffer_write(grid_buffer, buffer_f32, z1);
	
		// Normal vector (not important for a line though)
		buffer_write(grid_buffer, buffer_s32, 0);
		buffer_write(grid_buffer, buffer_s32, 0);
		buffer_write(grid_buffer, buffer_s32, 0);
	
		// Texcoord (not important too)
		buffer_write(grid_buffer, buffer_u32, 0);
		buffer_write(grid_buffer, buffer_u32, 0);
	
		// Color values and alpha value (r, g, b, a)
		buffer_write(grid_buffer, buffer_u8, int_r);
		buffer_write(grid_buffer, buffer_u8, int_g);
		buffer_write(grid_buffer, buffer_u8, int_b);
		buffer_write(grid_buffer, buffer_u8, int_a);
	
		// Second vertex point position (the "to"-coord)
		buffer_write(grid_buffer, buffer_f32, x2);
		buffer_write(grid_buffer, buffer_f32, y2);
		buffer_write(grid_buffer, buffer_f32, z2);
	
		// Normal vector (not important for a line though)
		buffer_write(grid_buffer, buffer_s32, 0);
		buffer_write(grid_buffer, buffer_s32, 0);
		buffer_write(grid_buffer, buffer_s32, 0);
	
		// Texcoord (not important too)
		buffer_write(grid_buffer, buffer_u32, 0);
		buffer_write(grid_buffer, buffer_u32, 0);
	
		// Color values and alpha value (r, g, b, a)
		buffer_write(grid_buffer, buffer_u8, int_r);
		buffer_write(grid_buffer, buffer_u8, int_g);
		buffer_write(grid_buffer, buffer_u8, int_b);
		buffer_write(grid_buffer, buffer_u8, int_a);
	}
	
	var grid_vertex_buffer = vertex_create_buffer_from_buffer(grid_buffer, o_softwareManager.vformat);
	buffer_delete(grid_buffer);
	
	return grid_vertex_buffer;
}