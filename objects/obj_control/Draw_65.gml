/// @description Resize Window

var baseW = 1920,
	baseH = 1080,
	ratio = baseW / baseH,
	scale = 8;

global.HEIGHT = floor(min(baseH, window_get_height()) / scale - 1);
global.WIDTH = floor(global.HEIGHT * ratio);

surface_resize(application_surface, global.WIDTH, global.HEIGHT);
