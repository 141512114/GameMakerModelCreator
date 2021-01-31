/// @function vertex_add_point(x, y, z, size, color, alpha);

/// @param xx
/// @param yy
/// @param zz
/// @param size
/// @param color
/// @param alpha

function vertex_create_cube(xx, yy, zz, size, color, alpha) {
	// Create cube test model
	var vCube = vertex_create_buffer();
	vertex_begin(vCube, o_softwareManager.vformat);

	// Cube model: bottom
	vertex_add_point(vCube, xx, yy, zz, 0, 0, -1, 0, 0, color, alpha);
	vertex_add_point(vCube, xx+size, yy, zz, 0, 0, -1, 1, 0, color, alpha);
	vertex_add_point(vCube, xx+size, yy+size, zz, 0, 0, -1, 1, 1, color, alpha);

	vertex_add_point(vCube, xx+size, yy+size, zz, 0, 0, -1, 1, 1, color, alpha);
	vertex_add_point(vCube, xx, yy+size, zz, 0, 0, -1, 0, 1, color, alpha);
	vertex_add_point(vCube, xx, yy, zz, 0, 0, -1, 0, 0, color, alpha);

	// Cube model: front
	vertex_add_point(vCube, xx, yy, zz, 0, -1, 0, 0, 0, color, alpha);
	vertex_add_point(vCube, xx, yy, zz+size, 0, -1, 0, 1, 0, color, alpha);
	vertex_add_point(vCube, xx+size, yy, zz+size, 0, -1, 0, 1, 1, color, alpha);
	
	vertex_add_point(vCube, xx+size, yy, zz+size, 0, -1, 0, 1, 1, color, alpha);
	vertex_add_point(vCube, xx+size, yy, zz, 0, -1, 0, 0, 1, color, alpha);
	vertex_add_point(vCube, xx, yy, zz, 0, -1, 0, 0, 0, color, alpha);

	// Cube model: left
	vertex_add_point(vCube, xx, yy, zz, -1, 0, 0, 0, 0, color, alpha);
	vertex_add_point(vCube, xx, yy+size, zz, -1, 0, 0, 1, 0, color, alpha);
	vertex_add_point(vCube, xx, yy+size, zz+size, -1, 0, 0, 1, 1, color, alpha);
	
	vertex_add_point(vCube, xx, yy+size, zz+size, -1, 0, 0, 1, 1, color, alpha);
	vertex_add_point(vCube, xx, yy, zz+size, -1, 0, 0, 0, 1, color, alpha);
	vertex_add_point(vCube, xx, yy, zz, -1, 0, 0, 0, 0, color, alpha);

	// Cube model: back
	vertex_add_point(vCube, xx, yy+size, zz, 0, 1, 0, 0, 0, color, alpha);
	vertex_add_point(vCube, xx+size, yy+size, zz, 0, 1, 0, 1, 0, color, alpha);
	vertex_add_point(vCube, xx+size, yy+size, zz+size, 0, 1, 0, 1, 1, color, alpha);
	
	vertex_add_point(vCube, xx+size, yy+size, zz+size, 0, 1, 0, 1, 1, color, alpha);
	vertex_add_point(vCube, xx, yy+size, zz+size, 0, 1, 0, 0, 1, color, alpha);
	vertex_add_point(vCube, xx, yy+size, zz, 0, 1, 0, 0, 0, color, alpha);

	// Cube model: right
	vertex_add_point(vCube, xx+size, yy, zz, 1, 0, 0, 0, 0, color, alpha);
	vertex_add_point(vCube, xx+size, yy+size, zz, 1, 0, 0, 1, 0, color, alpha);
	vertex_add_point(vCube, xx+size, yy+size, zz+size, 1, 0, 0, 1, 1, color, alpha);
	
	vertex_add_point(vCube, xx+size, yy+size, zz+size, 1, 0, 0, 1, 1, color, alpha);
	vertex_add_point(vCube, xx+size, yy, zz+size, 1, 0, 0, 0, 1, color, alpha);
	vertex_add_point(vCube, xx+size, yy, zz, 1, 0, 0, 0, 0, color, alpha);

	// Cube model: top
	vertex_add_point(vCube, xx, yy, zz+size, 0, 0, 1, 0, 0, color, alpha);
	vertex_add_point(vCube, xx, yy+size, zz+size, 0, 0, 1, 1, 0, color, alpha);
	vertex_add_point(vCube, xx+size, yy+size, zz+size, 0, 0, 1, 1, 1, color, alpha);
	
	vertex_add_point(vCube, xx+size, yy+size, zz+size, 0, 0, 1, 1, 1, color, alpha);
	vertex_add_point(vCube, xx+size, yy, zz+size, 0, 0, 1, 0, 1, color, alpha);
	vertex_add_point(vCube, xx, yy, zz+size, 0, 0, 1, 0, 0, color, alpha);

	vertex_end(vCube);
	
	return vCube;
}