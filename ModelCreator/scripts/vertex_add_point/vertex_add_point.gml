/// @function vertex_add_point(vbuffer, x, y, z, nx, ny, nz, u, v, color, alpha);

/// @param vbuffer
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

function vertex_add_point(vbuffer, xx, yy, zz, nx, ny, nz, u, v, color, alpha) {
	vertex_position_3d(vbuffer, xx, yy, zz);
	vertex_normal(vbuffer, nx, ny, nz);
	vertex_texcoord(vbuffer, u, v);
	vertex_color(vbuffer, color, alpha);
}