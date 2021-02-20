if (instance_exists(o_userControl)) {
	var follow_obj = o_userControl;
	
	xfrom = follow_obj.x;
	yfrom = follow_obj.y;
	zfrom = follow_obj.z + player_height;
	
	// To whereever the user looks at
	xto = xfrom + dcos(follow_obj.look_dir) * dcos(follow_obj.look_pitch);
	yto = yfrom - dsin(follow_obj.look_dir) * dcos(follow_obj.look_pitch);
	zto = zfrom - dsin(follow_obj.look_pitch);
	
	// Function for getting the position of the raycast point (where the user is looking at)
	function check_raypoint_pos(zfrom, view_xto, view_yto, view_zto, face_width, face_height) {
		if (view_xto > 0 && view_xto <= face_width) && (view_yto > 0 && view_yto <= face_height) {
			if (zfrom >= 0 && view_zto <= 0) || (zfrom <= 0 && view_zto >= 0) {
				show_debug_message("hello " + string(current_time));
			}
		}	
	}

	// Init the point where the user is looking at (with a distance)
	view_xto = xfrom + (dcos(follow_obj.look_dir) * dcos(follow_obj.look_pitch)) * raycast_dist;
	view_yto = yfrom - (dsin(follow_obj.look_dir) * dcos(follow_obj.look_pitch)) * raycast_dist;
	view_zto = zfrom - dsin(follow_obj.look_pitch) * raycast_dist;
	
	var face_width = room_width, face_height = room_height;
	
	// Check if the user is inside the object or raycast collider
	if (xfrom >= 0 && xfrom <= face_width) && (yfrom >= 0 && yfrom <= face_height) {
		check_raypoint_pos(zfrom, view_xto, view_yto, view_zto, face_width, face_height);
	} else {
		var origin_x = 0, origin_y = 0, origin_z = 0;
		var center_x = origin_x + face_width/2, center_y = origin_y + face_height/2;
		var user_pitch = sign(origin_z - zfrom) * follow_obj.look_pitch;
		
		var x_axis = sign(xfrom - center_x), y_axis = sign(yfrom - center_y);
		var x_start = x_axis * (xfrom-center_x), y_start = y_axis * (yfrom-center_y);
		show_debug_message("x_start: " + string(x_start) + ", y_start: " + string(y_start));
	
		// Check if the users x position is greater than the users y position
		if (y_start < x_start) {
			var anchor_x = center_x + (x_axis * (face_width/2));
			
			// Calculate the angle from the anchor point x to the users z position
			var dir_x = xfrom - anchor_x;
			var dir_z = sqrt(sqr(dir_x) + sqr(zfrom));
			var dir_pitch = x_axis * (radtodeg(arcsin(dir_x / dir_z)) - (x_axis * 90));
			
			show_debug_message("x: " + string(user_pitch) + ", " + string(dir_pitch));
			if (user_pitch >= dir_pitch) then check_raypoint_pos(zfrom, view_xto, view_yto, view_zto, face_width, face_height);
		} else if (x_start < y_start) {
			var anchor_y = center_y + (y_axis * (face_height/2));
		
			// Calculate the angle from the anchor point y to the users z position
			var dir_y = yfrom - anchor_y;
			var dir_z = sqrt(sqr(dir_y) + sqr(zfrom));
			var dir_pitch = y_axis * (radtodeg(arcsin(dir_y / dir_z)) - (y_axis * 90));
			
			show_debug_message("y: " + string(user_pitch) + ", " + string(dir_pitch));
			if (user_pitch >= dir_pitch) then check_raypoint_pos(zfrom, view_xto, view_yto, view_zto, face_width, face_height);
		}
	}
}