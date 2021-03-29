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
		
		var x3 = buffer_peek(model_buffer, i + 72, buffer_f32) + ox;
		var y3 = buffer_peek(model_buffer, i + 76, buffer_f32) + oy;
		var z3 = buffer_peek(model_buffer, i + 80, buffer_f32) + oz;
			
		show_debug_message("Ortsvektor: " + string(x1) + ", " + string(y1) + ", " + string(z1));
			
		// Calculate sizing vectors
		var sx1 = x2 - x1, sy1 = y2 - y1, sz1 = z2 - z1;
		var sx2 = x3 - x1, sy2 = y3 - y1, sz2 = z3 - z1;
		
		show_debug_message("Spannvektor Nr. 1: " + string(sx1) + ", " + string(sy1) + ", " + string(sz1));
		show_debug_message("Spannvektor Nr. 2: " + string(sx2) + ", " + string(sy2) + ", " + string(sz2));
		
		// Calculate the cross product (or more specific = the normal vector)
		var cpx = (sy1 * sz2) - (sz1 * sy2);
		var cpy = (sz1 * sx2) - (sx1 * sz2);
		var cpz = (sx1 * sy2) - (sy1 * sx2);
		
		show_debug_message("Normalenvektor: " + string(cpx) + ", " + string(cpy) + ", " + string(cpz));
		
		// Calculate the y offset of our surface
		var y_off = -(cpx * x1) - (cpy * y1) - (cpz * z1);
			
		// Save the calculated equation in an array
		triangle_faces_buffer[i/108] = [ [cpx, cpy, cpz, y_off], [x1, y1, z1], [sx1, sy1, sz1], [sx2, sy2, sz2] ];
			
		show_debug_message("Ebenengleichung: " + string(cpx) + "x" + string(cpy) + "y" + string(cpz) + "z " + string(y_off) + " = 0");
	}
	
	buffer_delete(model_buffer);
		
	return triangle_faces_buffer;
}