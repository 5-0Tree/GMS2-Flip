/// @description Resize Window

var baseW = 1920,
	baseH = 1080,
	ratio = baseW / baseH,
	scale = 8;

if (window_get_width() < window_get_height())
{
	global.WIDTH = ceil(min(baseW, window_get_width()) / scale);
	global.HEIGHT = ceil(global.WIDTH / ratio);
}

else
{
	global.HEIGHT = floor(min(baseH, window_get_height()) / scale - 1);
	global.WIDTH = floor(global.HEIGHT * ratio);
}

surface_resize(application_surface, global.WIDTH, global.HEIGHT);
