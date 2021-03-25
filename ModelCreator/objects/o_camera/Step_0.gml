if (instance_exists(o_userControl)) {
	var follow_obj = o_userControl;
	
	xfrom = follow_obj.x;
	yfrom = follow_obj.y;
	zfrom = follow_obj.z + player_height;
	
	// To whereever the user looks at
	xto = xfrom + dcos(follow_obj.look_dir) * dcos(follow_obj.look_pitch);
	yto = yfrom - dsin(follow_obj.look_dir) * dcos(follow_obj.look_pitch);
	zto = zfrom - dsin(follow_obj.look_pitch);

	// Init the point where the user is looking at (with a distance)
	view_xto = xfrom + (dcos(follow_obj.look_dir) * dcos(follow_obj.look_pitch)) * raycast_dist;
	view_yto = yfrom - (dsin(follow_obj.look_dir) * dcos(follow_obj.look_pitch)) * raycast_dist;
	view_zto = zfrom - dsin(follow_obj.look_pitch) * raycast_dist;
	
	if (mouse_check_button_pressed(mb_middle)) {
		prev_x_from = xfrom;
		prev_y_from = yfrom;
		prev_z_from = zfrom;
	
		prev_view_xto = view_xto;
		prev_view_yto = view_yto;
		prev_view_zto = view_zto;
	}
}