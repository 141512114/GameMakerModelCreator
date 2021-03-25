/// @function raycast_hit(object, x1, y1, z1, x2, y2, z2)

/// @param object
/// @param x1
/// @param y1
/// @param z1
/// @param x1
/// @param y2
/// @param z2

function raycast_hit(object, x1, y1, z1, x2, y2, z2){
	// Calculate direction vector (basically where we're looking)
	var dx = x2 - x1, dy = y2 - y1, dz = z2 - z1;
	
	show_debug_message("Richtungsvektor (Raycast): " + string(dx) + ", " + string(dy) + ", " + string(dz));
	
	// Loop through each instance with the same class type
	for (var inst_num = 0; inst_num < instance_number(object); inst_num++) {
		var current_inst = instance_find(object, inst_num);
		var triangle_faces = current_inst.triangle_faces;
		
		for (var i = 0; i < array_length(triangle_faces); i++) {
			// Get position and scalar product of current triangle
			var triangle_eq = triangle_faces[i];
		
			// Insert origin and direction vector into the triangles equation (calculate them seperately)
			var x_1 = triangle_eq[0] * x1, x_2 = triangle_eq[0] * dx;
			var y_1 = triangle_eq[1] * y1, y_2 = triangle_eq[1] * dy;
			var z_1 = triangle_eq[2] * z1, z_2 = triangle_eq[2] * dz;
		
			// Calculate both sums and then get the parameter r
			var sum_xyz_1 = x_1 + y_1 + z_1, sum_xyz_2 = x_2 + y_2 + z_2;
			var parameter_r = ( -(triangle_eq[3] + sum_xyz_1) ) / sum_xyz_2;
			
			show_debug_message("Parameter r: " + string(parameter_r));
		
			// Insert the parameter r into our line equation (view direction)
			// Get new point (the possible coliding point)
			var r_dx = dx * parameter_r, r_dy = dy * parameter_r, r_dz = dz * parameter_r;
			var sx = x1 + r_dx, sy = y1 + r_dy, sz = z1 + r_dz;
			
			show_debug_message("Schnittpunkt: " + string(sx) + ", " + string(sy) + ", " + string(sz));
		
			// Insert the new point into the triangle equation and check if the two equations are coliding
			var e_sx = triangle_eq[0] * sx, e_sy = triangle_eq[1] * sy, e_sz = triangle_eq[2] * sz;
			var sum_e_s_xyz = e_sx + e_sy + e_sz + triangle_eq[3];
			
			show_debug_message(string(triangle_eq[0]) + " * " + string(sx) + " + " + string(triangle_eq[1]) + " * " + string(sy) + " + " + string(triangle_eq[2]) + " * " + string(sz) + " + " + string(triangle_eq[3]) + " = 0");
			show_debug_message(sum_e_s_xyz);
		
			if (sum_e_s_xyz == 0) then show_debug_message("Collision?");
		}
	}
}