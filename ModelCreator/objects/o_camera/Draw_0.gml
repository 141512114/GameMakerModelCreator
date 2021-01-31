// Reset screen so it doesn't get filled with the ground getting "duplicated"
draw_clear(c_black);

// Create the 3d camera
var camera = camera_get_active();

var follow_obj = o_userControl, player_height = 100;
var xfrom = follow_obj.x;
var yfrom = follow_obj.y;
var zfrom = follow_obj.z + player_height;
// To whereever the player looks at
var xto = xfrom + dcos(follow_obj.look_dir) * dcos(follow_obj.look_pitch);
var yto = yfrom - dsin(follow_obj.look_dir) * dcos(follow_obj.look_pitch);
var zto = zfrom - dsin(follow_obj.look_pitch);

camera_set_view_mat(camera, matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1));
camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(-60, window_get_width() / window_get_height(), 1, 32000));
camera_apply(camera);

// Enable lighting
shader_set(shd_lighting);

shader_set_uniform_f(shader_get_uniform(shd_lighting, "u_vLightDir"), -1, 1, -1);
shader_set_uniform_f(shader_get_uniform(shd_lighting, "u_vLightColor"), 1, 1, 1, 1);

// Draw the floor we created (apply a grass texture)
vertex_submit(o_softwareManager.vbuffer, pr_trianglelist, sprite_get_texture(s_grid, 0));
with (o_element) event_perform(ev_draw, 0);

shader_reset();