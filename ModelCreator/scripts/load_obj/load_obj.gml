/// @param filename

function load_obj(filename, mtlname) {
	// Open .obj file
	var obj_file = file_text_open_read(filename);
	var mtl_file = file_text_open_read(mtlname);
	
	var mtl_name = "None";
	var active_mtl = "None";
	
	var mtl_alpha = ds_map_create();
	var mtl_color = ds_map_create();
	
	ds_map_add(mtl_color, "None", c_white);
	ds_map_add(mtl_alpha, "None", 1);
	
	while (!file_text_eof(mtl_file)) {
		var line = file_text_read_string(mtl_file);
		file_text_readln(mtl_file);
		
		// Split each line around the space character
		var terms, index = 0;
		terms = array_create(string_count(line, " ") + 1, "");
		
		for (var i = 1; i <= string_length(line); i++) {
			if (string_char_at(line, i) == " ") {
				index++;
				terms[index] = "";
			} else {
				terms[index] += string_char_at(line, i);
			}
		}
		
		switch (terms[0]) {
			case "newmtl":
				mtl_name = terms[1];
				break;
				
			case "Kd":
				var r = real(terms[1]) * 255, g = real(terms[2]) * 255, b = real(terms[3]) * 255;
				var color = make_color_rgb(r, g, b);
				ds_map_set(mtl_color, mtl_name, color);
				break;
				
			case "d":
				var alpha = real(terms[1]);
				ds_map_set(mtl_alpha, mtl_name, alpha);
				break;
				
			default:
				break;
		}
	}
	
	// Create vertex buffer for the model
	var model = vertex_create_buffer();
	vertex_begin(model, o_gameManager.vformat);
	
	// Create ds_lists which will contain information about the model
	var vertex_x = ds_list_create();
	var vertex_y = ds_list_create();
	var vertex_z = ds_list_create();
	
	var normal_x = ds_list_create();
	var normal_y = ds_list_create();
	var normal_z = ds_list_create();
	
	var vertex_xtex = ds_list_create();
	var vertex_ytex = ds_list_create();
	
	// Read each line in the file
	while (!file_text_eof(obj_file)) {
		var line = file_text_read_string(obj_file);
		file_text_readln(obj_file);
		
		// Split each line around the space character
		var terms, index = 0;
		terms = array_create(string_count(line, " ") + 1, "");
		
		for (var i = 1; i <= string_length(line); i++) {
			if (string_char_at(line, i) == " ") {
				index++;
				terms[index] = "";
			} else {
				terms[index] += string_char_at(line, i);
			}
		}
		
		switch (terms[0]) {
			// Add the vertex x, y an z position to their respective lists
			case "v":
				ds_list_add(vertex_x, real(terms[1]));
				ds_list_add(vertex_y, real(terms[2]));
				ds_list_add(vertex_z, real(terms[3]));
				break;
			
			// Add the vertex x and y texture position (or "u" and "v") to their respective lists
			case "vt":
				ds_list_add(vertex_xtex, real(terms[1]));
				ds_list_add(vertex_ytex, real(terms[2]));
				break;
				
			// Add the vertex normal's x, y and z components to their respective lists
			case "vn":
				ds_list_add(normal_x, real(terms[1]));
				ds_list_add(normal_y, real(terms[2]));
				ds_list_add(normal_z, real(terms[3]));
				break;
				
			// Build faces
			case "f":
				// Split each term around the slash character
				for (var n = 1; n < 4; n++) {
					var data, index = 0;
					data = array_create(string_count(terms[n], "/") + 1, "");
					
					for (var i = 1; i <= string_length(terms[n]); i++) {
						if (string_char_at(terms[n], i) == "/") {
							index++;
							data[index] = "";
						} else {
							data[index] += string_char_at(terms[n], i);
						}
					}
					
					// Look up the x, y, z, normal x, y, z and texture x, y in the already-created lists
					var xx = ds_list_find_value(vertex_x, real(data[0])-1);
					var yy = ds_list_find_value(vertex_y, real(data[0])-1);
					var zz = ds_list_find_value(vertex_z, real(data[0])-1);
					
					var xtex = ds_list_find_value(vertex_xtex, real(data[1])-1);
					var ytex = ds_list_find_value(vertex_ytex, real(data[1])-1);
					
					var nx = ds_list_find_value(normal_x, real(data[2])-1);
					var ny = ds_list_find_value(normal_y, real(data[2])-1);
					var nz = ds_list_find_value(normal_z, real(data[2])-1);
					
					var color = c_white, alpha = 1;
					if (ds_map_exists(mtl_color, active_mtl)) then color = ds_map_find_value(mtl_color, active_mtl);
					if (ds_map_exists(mtl_alpha, active_mtl)) then alpha = ds_map_find_value(mtl_alpha, active_mtl);
					
					// Swap the y and z positions
					var t = yy;
					yy = zz;
					zz = t;
					// Same needs to be made with the normals
					var s = ny;
					ny = nz;
					nz = s;
					
					// Add the data to the vertex buffers
					vertex_position_3d(model, xx, yy, zz);
					vertex_normal(model, nx, ny, nz);
					vertex_texcoord(model, xtex, ytex);
					vertex_color(model, color, alpha);
				}
				break;
				
			case "usemtl":
				active_mtl = terms[1];
				break;
				
			default:
				break;
		}
	}
	
	// End the vertex buffer, destroy the lists, close the text file and return the vertex buffer
	vertex_end(model);
	
	ds_list_destroy(vertex_x);
	ds_list_destroy(vertex_y);
	ds_list_destroy(vertex_z);
	
	ds_list_destroy(vertex_xtex);
	ds_list_destroy(vertex_ytex);
	
	ds_list_destroy(normal_x);
	ds_list_destroy(normal_y);
	ds_list_destroy(normal_z);
	
	ds_map_destroy(mtl_alpha);
	ds_map_destroy(mtl_color);
	
	file_text_close(obj_file);
	file_text_close(mtl_file);
	return model;
}