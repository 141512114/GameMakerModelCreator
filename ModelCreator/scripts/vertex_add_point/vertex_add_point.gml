/// @function vertex_add_point(vbuffer, vertex_list, x, y, z, nx, ny, nz, u, v, color, alpha);

/// @param vbuffer
/// @param vlist
/// @param xx
/// @param yy
/// @param zz
/// @param nx
/// @param ny
/// @param nz
/// @param u
/// @param v
/// @param color
/// @param alpha

function vertex_add_point(vbuffer, vlist, xx, yy, zz, nx, ny, nz, u, v, color, alpha) {
	vertex_position_3d(vbuffer, xx, yy, zz);
	vertex_normal(vbuffer, nx, ny, nz);
	vertex_texcoord(vbuffer, u, v);
	vertex_color(vbuffer, color, alpha);
	
	// Save every vertex point inside a list
	if (vlist != -1) then ds_list_add(vlist, [xx, yy, zz, nx, ny, nz, u, v, color, alpha]);
}