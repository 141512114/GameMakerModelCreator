// Rotation (roll, pitch)
look_dir += (window_mouse_get_x() - window_get_width() / 2) / sensitivity;
look_pitch += (window_mouse_get_y() - window_get_height() / 2) / sensitivity;
look_pitch = clamp(look_pitch, -89, 89);

// Lock cursor to the center of the window
window_mouse_set(window_get_width() / 2, window_get_height() / 2);
if (keyboard_check_direct(vk_escape)) then game_end(); // Emergency exit

// Movement
var w_s_move = sign(keyboard_check(ord("W")) - keyboard_check(ord("S")));
if (w_s_move != 0) {
	x += w_s_move * dcos(look_dir) * move_speed;
	y += -(w_s_move * dsin(look_dir)) * move_speed;
	z += -(w_s_move * dsin(look_pitch)) * move_speed;
}

var a_d_move = sign(keyboard_check(ord("D")) - keyboard_check(ord("A")));
if (a_d_move != 0) {
	x -= a_d_move * dsin(look_dir) * move_speed;
	y -= a_d_move * dcos(look_dir) * move_speed;
}