/// @description Init

_spd = -1;
spd = 4;

xTo = x;
yTo = y;

dragStart = false;

dragX = x;
dragY = y;

x = clamp(x, 64, room_width - global.WIDTH / 2 - 64);
y = clamp(y, 64, room_height - global.HEIGHT / 2 - 64);

ZOOM = 1;

cam = camera_create();

var vm = matrix_build_lookat(x, y, -100, x, y, 0, 0, 1, 0),
	pm = matrix_build_projection_ortho(global.WIDTH, global.HEIGHT, 1.0, 32000.0);

camera_set_view_mat(cam, vm);
camera_set_proj_mat(cam, pm);

view_camera[0] = cam;
