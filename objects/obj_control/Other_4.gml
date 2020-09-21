/// @description Init

var baseW = 1920,
	baseH = 1080,
	ratio = baseW / baseH,
	scale = 8;

if (display_get_width() < display_get_height())
{
	global.WIDTH = ceil(min(baseW, display_get_width()) / scale);
	global.HEIGHT = ceil(global.WIDTH / ratio);
}

else
{
	global.HEIGHT = ceil(min(baseH, display_get_height()) / scale);
	global.WIDTH = ceil(global.HEIGHT * ratio);
}

surface_resize(application_surface, global.WIDTH, global.HEIGHT);

if (!instance_exists(obj_editor_control))
{
	global.edit = false;
}

global.screenRotSpd = 5;
global.screenAngle = 0;
global.canRotate = false;
global.angleFix = 0;

if (room = rm_init)
{
	room_goto_next();
}
