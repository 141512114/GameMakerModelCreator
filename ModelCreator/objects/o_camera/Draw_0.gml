// Reset screen so it doesn't get filled with the ground getting "duplicated"
draw_clear(c_black);

// Create the 3d camera
var camera = camera_get_active();

camera_set_view_mat(camera, matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1));
camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(-60, window_get_width() / window_get_height(), 1, 32000));
camera_apply(camera);

// Draw raycast (view line of the user)
var view_line = draw_line_3d(prev_x_from, prev_y_from, prev_z_from, prev_view_xto, prev_view_yto, prev_view_zto, c_red, 1);
vertex_submit(view_line, pr_linelist, -1);
vertex_delete_buffer(view_line);

// Draw grid
vertex_submit(grid_vertex_buffer, pr_linelist, -1);

if (raycast_hit(o_element, xfrom, yfrom, zfrom, xto, yto, zto)) then show_debug_message("Collision?");

// Draw every 3d object in the scene / room
// Enable lighting
shader_set(shd_lighting);

shader_set_uniform_f(shader_get_uniform(shd_lighting, "u_vLightDir"), -1, 1, -1);
shader_set_uniform_f(shader_get_uniform(shd_lighting, "u_vLightColor"), 1, 1, 1, 1);

with (o_element) event_perform(ev_draw, 0);

shader_reset();

with (o_vertex_point) event_perform(ev_draw, 0);