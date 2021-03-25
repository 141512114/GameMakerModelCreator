// Rotation (roll, pitch)
look_dir += (window_mouse_get_x() - window_get_width() / 2) / sensitivity;
look_pitch += (window_mouse_get_y() - window_get_height() / 2) / sensitivity;
look_pitch = clamp(look_pitch, -89, 89);

// Lock cursor to the center of the window
window_mouse_set(window_get_width() / 2, window_get_height() / 2);
if (keyboard_check_direct(vk_escape)) then game_end();

// Movement
var dx = 0, dy = 0, len = 0;

var w_s_move = sign(keyboard_check(ord("W")) - keyboard_check(ord("S")));
if (w_s_move != 0) {
	dx += w_s_move * dcos(look_dir) * move_speed;
	dy += -(w_s_move * dsin(look_dir)) * move_speed;
	z += -(w_s_move * dsin(look_pitch)) * move_speed;
}

var a_d_move = sign(keyboard_check(ord("D")) - keyboard_check(ord("A")));
if (a_d_move != 0) {
	dx -= a_d_move * dsin(look_dir) * move_speed;
	dy -= a_d_move * dcos(look_dir) * move_speed;
}

if (a_d_move != 0 || w_s_move != 0) then len = move_speed;

// Fix diagonal movement (speed fix)
var dir = point_direction(0, 0, dx, dy);
var len_x = 0, len_y = 0;
len_x = lengthdir_x(len, dir);
len_y = lengthdir_y(len, dir);

x += len_x;
y += len_y;