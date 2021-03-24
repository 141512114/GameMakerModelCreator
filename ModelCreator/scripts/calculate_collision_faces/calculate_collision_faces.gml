/// @function calculate_collision_faces(object)

/// @param object

function calculate_collision_faces(object) {
	var model_buffer = buffer_create_from_vertex_buffer(object.model, buffer_fixed, 1);
	var triangle_faces_buffer = [];
	
	var ox = object.x, oy = object.y, oz = object.z;

	for (var i = 0; i < buffer_get_size(model_buffer); i += 108) {
		// Get two points of every triangle of the model
		var x1 = buffer_peek(model_buffer, i + 0, buffer_f32) + ox;
		var y1 = buffer_peek(model_buffer, i + 4, buffer_f32) + oy;
		var z1 = buffer_peek(model_buffer, i + 8, buffer_f32) + oz;
			
		var x2 = buffer_peek(model_buffer, i + 36, buffer_f32) + ox;
		var y2 = buffer_peek(model_buffer, i + 40, buffer_f32) + oy;
		var z2 = buffer_peek(model_buffer, i + 44, buffer_f32) + oz;
			
		show_debug_message("Ortsvektor: " + string(x1) + ", " + string(y1) + ", " + string(z1));
		show_debug_message("Richtungsvektor: " + string(x2) + ", " + string(y2) + ", " + string(z2));
			
		// Calculate direction vector
		var dx = x2 - x1, dy = y2 - y1, dz = z2 - z1;
			
		// Calculate the cross product (or more specific = the normal vector)
		var cpx = y1 * dz - z1 * dy;
		var cpy = z1 * dx - x1 * dz;
		var cpz = x1 * dy - y1 * dx;
			
		// Calculate scalar product
		var scalar = x1 * dx + y1 * dy + z1 * dz;
			
		// Save the calculated equation in an array
		triangle_faces_buffer[i/108] = [[cpx, cpy, cpz], scalar];
			
		show_debug_message("Ebenengleichung: " + string(cpx) + "x" + string(cpy) + "y" + string(cpz) + "z = " + string(scalar))
	}

	buffer_delete(model_buffer);
		
	return triangle_faces_buffer;
}