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
	
	// show_debug_message("Richtungsvektor (Raycast): " + string(dx) + ", " + string(dy) + ", " + string(dz));
	
	// Loop through each instance with the same class type
	for (var inst_num = 0; inst_num < instance_number(object); inst_num++) {
		var current_inst = instance_find(object, inst_num);
		var triangle_faces = current_inst.triangle_faces;
		
		for (var i = 0; i < array_length(triangle_faces); i++) {
			var current_triangle = triangle_faces[i];
			
			// Get position and scalar product of current triangle
			var triangle_eq = current_triangle[0];
		
			// Insert origin and direction vector into the triangles equation (calculate them seperately)
			var x_1 = triangle_eq[0] * x1, x_2 = triangle_eq[0] * dx;
			var y_1 = triangle_eq[1] * y1, y_2 = triangle_eq[1] * dy;
			var z_1 = triangle_eq[2] * z1, z_2 = triangle_eq[2] * dz;
		
			// Calculate both sums and then get the parameter r
			var sum_xyz_1 = x_1 + y_1 + z_1, sum_xyz_2 = x_2 + y_2 + z_2;
			var parameter_r = ( -(triangle_eq[3] + sum_xyz_1) ) / sum_xyz_2;
			
			// show_debug_message("Parameter r: " + string(parameter_r));
		
			// Insert the parameter r into our line equation (view direction)
			// Get new point (the possible coliding point)
			var r_dx = dx * parameter_r, r_dy = dy * parameter_r, r_dz = dz * parameter_r;
			var sx = x1 + r_dx, sy = y1 + r_dy, sz = z1 + r_dz;
			
			// show_debug_message("Schnittpunkt: " + string(sx) + ", " + string(sy) + ", " + string(sz));
		
			// Initialize system of equations
			// Set parameter r and s and calculate the right side of every equation
			var sys_value_param_r = 0, sys_value_param_s = 0;
			var sys_x_r = sx - current_triangle[1][0], sys_y_r = sy - current_triangle[1][1], sys_z_r = sz - current_triangle[1][2];
			
			/*
			show_debug_message("Ortsvektor: " + string(current_triangle[1]));
			show_debug_message("Spannvektor Nr. 1: " + string(current_triangle[2]));
			show_debug_message("Spannvektor Nr. 2: " + string(current_triangle[3]));
			*/
			
			// Check if the first value of both equations isn't 0
			if (current_triangle[2][0] != 0 && current_triangle[2][1] != 0) {
				// Get the multiplicator
				var sys_first_eq_m = current_triangle[2][1] / current_triangle[2][0];
				
				// show_debug_message("sys_first_eq_m: " + string(sys_first_eq_m));
				
				// Calculate the new equation by subtracting the first from the second one
				var sys_new_y = sys_y_r - (sys_x_r * sys_first_eq_m);
				var sys_new_sec_eq_param_r = current_triangle[2][1] - (current_triangle[2][0] * sys_first_eq_m), sys_new_sec_eq_param_s = current_triangle[3][1] - (current_triangle[3][0] * sys_first_eq_m);
				
				// show_debug_message("sys_new_y: " + string(sys_new_y) + ", sys_new_sec_eq_param_r: " + string(sys_new_sec_eq_param_r) + ", sys_new_sec_eq_param_s: " + string(sys_new_sec_eq_param_s));
				
				// If we successfully got rid of the parameter r in this equation and still have a parameter s
				// Calculate both parameter r and s
				if (sys_new_sec_eq_param_r == 0 && sys_new_sec_eq_param_s != 0) {
					sys_value_param_s = sys_new_y / sys_new_sec_eq_param_s;
				}
			} else {
				// Check whether the first or second equation has no parameter r
				// Then calculate parameter s
				if (current_triangle[2][0] == 0) {
					if (current_triangle[3][0] == 0) {
						sys_value_param_s = sys_x_r;
					} else {
						sys_value_param_s = sys_x_r / current_triangle[3][0];
					}
				} else if (current_triangle[2][1] == 0) {
					if (current_triangle[3][1] == 0) {
						sys_value_param_s = sys_y_r;
					} else {
						sys_value_param_s = sys_y_r / current_triangle[3][1];
					}
				}
			}
			
			// Insert the parameter s into the third equation
			var sys_new_z = sys_z_r - (current_triangle[3][2] * sys_value_param_s);
				
			// Make sure the multiplicator for the parameter r in the third equation is not equal to 0
			if (current_triangle[2][2] == 0) {
				sys_value_param_r = sys_new_z;
			} else {
				sys_value_param_r = sys_new_z / current_triangle[2][2];
			}
			
			// show_debug_message("sys_value_param_r: " + string(sys_value_param_r) + ", sys_value_param_s: " + string(sys_value_param_s));
			
			// If both parameters are greater than 0 and their sum is lower or equal to 1 => Collision
			if ( (sys_value_param_r >= 0 && sys_value_param_s >= 0) && sys_value_param_r+sys_value_param_s <= 1) then return true;
		}
	}
}