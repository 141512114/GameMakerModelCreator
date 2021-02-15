gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

c_init()
c_world_create();

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
		
		vertex_add_point(vbuffer, -1, i, j, zz, 0, 0, 1, 0, 0, color, 1);
		vertex_add_point(vbuffer, -1, i+size, j, zz, 0, 0, 1, 1, 0, color, 1);
		vertex_add_point(vbuffer, -1, i+size, j+size, zz, 0, 0, 1, 1, 1, color, 1);

		vertex_add_point(vbuffer, -1, i+size, j+size, zz, 0, 0, 1, 1, 1, color, 1);
		vertex_add_point(vbuffer, -1, i, j+size, zz, 0, 0, 1, 0, 1, color, 1);
		vertex_add_point(vbuffer, -1, i, j, zz, 0, 0, 1, 0, 0, color, 1);
	}
}

vertex_end(vbuffer);

// Instantiate objects
var xppos = room_width / 2, yppos = room_height / 2;
instance_create_depth(xppos, yppos, 0, o_camera);
instance_create_depth(xppos, yppos, 0, o_userControl);

var cube_size = 96;
var cube_x = xppos - cube_size/2, cube_y = yppos - cube_size/2, cube_z = 25;
var el_obj = instance_create_depth(cube_x, cube_y, 0, o_element);
el_obj.vlist = ds_list_create();
el_obj.model = vertex_create_cube(el_obj.vlist, 0, 0, 0, cube_size, c_gray, 1);
el_obj.z = cube_z;

if (el_obj.vlist != -1) {
	var vlen = ds_list_size(el_obj.vlist), vcube_size = 10, v_pos_list = ds_list_create();
	for (var i = 0; i < vlen; i++) {
		var xx = el_obj.x + ds_list_find_value(el_obj.vlist, i)[0] - vcube_size/2;
		var yy = el_obj.y + ds_list_find_value(el_obj.vlist, i)[1] - vcube_size/2;
		var zz = el_obj.z + ds_list_find_value(el_obj.vlist, i)[2] - vcube_size/2;
		
		var v_pos_len = ds_list_size(v_pos_list)-1;
		
		// Check if our list has entries
		var same_vertex_pos = 0; if (v_pos_len > -1) {
			var j = 0; while (j <= v_pos_len) {
				// Check if the row exists (has a valid value)
				if (ds_list_find_value(v_pos_list, j) != undefined && ds_list_find_value(v_pos_list, j) != -1) {
					var v_value = ds_list_find_value(v_pos_list, j);
					
					// Check if it's exactly the same position
					if (xx == v_value[0] && yy == v_value[1] && zz == v_value[2]) then same_vertex_pos++;
				
					j++;
				}
			}
		}
		
		// Check if there are no vertecies with the same position
		if (same_vertex_pos <= 0) {
			var vpoint_obj = instance_create_depth(xx, yy, 0, o_vertex_point);
			vpoint_obj.z = zz;
			vpoint_obj.model = vertex_create_cube(-1, 0, 0, 0, vcube_size, c_orange, 1);
			
			var c_shape_vpoint = c_shape_create();
			c_shape_add_box(c_shape_vpoint, vcube_size/2, vcube_size/2, vcube_size/2);
			
			c_world_add_object(c_object_create(c_shape_vpoint, -1, 1));
			
			// Add the new vertex position to the list
			ds_list_add(v_pos_list, [xx, yy, zz]);
		}
	}
	// Destroy the temporary list
	ds_list_destroy(v_pos_list);
}