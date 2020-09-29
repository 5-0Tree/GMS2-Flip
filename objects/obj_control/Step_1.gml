/// @description Adjust Settings

if (keyboard_check_pressed(vk_f11))
{
	fullscreen = !fullscreen;
	
	window_set_fullscreen(fullscreen)
}

if (keyboard_check_pressed(ord("G")))
{
	showGrid = !showGrid;
}
