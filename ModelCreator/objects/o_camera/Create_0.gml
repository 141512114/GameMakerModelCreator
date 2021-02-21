// Initialize camera settings
player_height = 100;
raycast_dist = 250;

// Important for raycast
xfrom = 0;
yfrom = 0;
zfrom = 0;

xto = 0;
yto = 0;
zto = 0;

view_xto = 0;
view_yto = 0;
view_zto = 0;

prev_x_from = 0;
prev_y_from = 0;
prev_z_from = 0;

prev_view_xto = 0;
prev_view_yto = 0;
prev_view_zto = 0;

// Important for grid
grid_vertex_buffer = create_grid(0, 0, 0, 64, room_width, room_height, c_white, 1);