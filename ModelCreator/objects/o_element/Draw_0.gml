// Draw model
draw_set_color(c_white);

matrix_set(matrix_world, matrix_build(x, y, z, 0, 0, 0, xsize, ysize, zsize));
if (model != -1) then vertex_submit(model, pr_trianglelist, texture);
matrix_set(matrix_world, matrix_build_identity());