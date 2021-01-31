gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

// Vertex format
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
vformat = vertex_format_end();

vbuffer = vertex_create_buffer();
vertex_begin(vbuffer, vformat);

// Create floor
var size = 128, zz = 0;
for (var i = 0; i < room_width; i += size) {
	for (var j = 0; j < room_height; j += size) {
		var color = c_white;
		
		vertex_add_point(vbuffer, i, j, zz, 0, 0, 1, 0, 0, color, 1);
		vertex_add_point(vbuffer, i+size, j, zz, 0, 0, 1, 1, 0, color, 1);
		vertex_add_point(vbuffer, i+size, j+size, zz, 0, 0, 1, 1, 1, color, 1);

		vertex_add_point(vbuffer, i+size, j+size, zz, 0, 0, 1, 1, 1, color, 1);
		vertex_add_point(vbuffer, i, j+size, zz, 0, 0, 1, 0, 1, color, 1);
		vertex_add_point(vbuffer, i, j, zz, 0, 0, 1, 0, 0, color, 1);
	}
}

vertex_end(vbuffer);

// Instantiate objects
var xppos = room_width / 2, yppos = room_height / 2;
instance_create_depth(xppos, yppos, 0, o_camera);
instance_create_depth(xppos, yppos, 0, o_userControl);

var cube_size = 96;
var el_obj = instance_create_depth(xppos - cube_size/2, yppos - cube_size/2, 0, o_element);
el_obj.model = vertex_create_cube(0, 0, 0, cube_size, c_gray, 1);
el_obj.z = 25;