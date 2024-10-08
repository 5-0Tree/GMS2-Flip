/// @description Panning

if (dragStart)
{
	x = floor((dragX - event_data[? "rawposX"]) / 8);
	y = floor((dragY - event_data[? "rawposY"]) / 8);
	
	x = clamp(x, 0, room_width - global.WIDTH / 2);
	y = clamp(y, 0, room_height - global.HEIGHT / 2);
	
	var CANG = dcos(global.screenAngle),
		SANG = dsin(global.screenAngle),
		vm = matrix_build_lookat(x, y, -100, x, y, 0, SANG, CANG, 0);
	
	camera_set_view_mat(cam, vm);
}
