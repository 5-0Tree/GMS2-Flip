/// @description Init

var baseW = 1920,
	baseH = 1080,
	ratio = baseW / baseH,
	scale = 4;

if (display_get_width() < display_get_height())
{
	WIDTH = min(baseW, display_get_width()) / scale;
	HEIGHT = WIDTH / ratio;
}

else
{
	HEIGHT = min(baseH, display_get_height()) / scale + 1;
	WIDTH = HEIGHT * ratio;
}

surface_resize(application_surface, WIDTH, HEIGHT);

_spd = -1;
spd = 4;

xTo = x;
yTo = y;

ZOOM = 1;

cam = camera_create();

var vm = matrix_build_lookat(x, y, -100, x, y, 0, 0, 1, 0),
	pm = matrix_build_projection_ortho(WIDTH, HEIGHT, 1.0, 32000.0);

camera_set_view_mat(cam, vm);
camera_set_proj_mat(cam, pm);

view_camera[0] = cam;
