/// @description Init

var baseW = 1920,
	baseH = 1080,
	ratio = baseW / baseH,
	scale = 8;

global.HEIGHT = floor(min(baseH, window_get_height()) / scale - 1);
global.WIDTH = floor(global.HEIGHT * ratio);

surface_resize(application_surface, global.WIDTH, global.HEIGHT);

if (!instance_exists(obj_editor_control))
{
	global.edit = false;
}

depth = 100;

fullscreen = window_get_fullscreen();

showGrid = true;

global.screenRotSpd = 5;
global.screenAngle = 0;
global.canRotate = false;
global.angleFix = 0;

global.gameOver = false;

if (room = rm_init)
{
	random_set_seed(irandom(1000000000));
	
	room_goto_next();
}
