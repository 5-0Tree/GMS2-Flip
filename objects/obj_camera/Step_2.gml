/// @description Camera Movement

global.screenAngle += ((global.angleFix - global.screenAngle) / global.screenRotSpd);

if (!global.edit)
{
	if (_spd == -1)
	{
		if (instance_number(obj_player) == 1)
		{
			x = obj_player.x;
			y = obj_player.y;
			
			xTo = obj_player.x;
			yTo = obj_player.y;
		}
		
		_spd = spd;
	}
	
	x += (xTo - x) / _spd;
	y += (yTo - y) / _spd;
	
	if (instance_number(obj_player) == 1)
	{
		xTo = obj_player.x;
		yTo = obj_player.y;
	}
}

else
{
	x = clamp(x, 64, room_width - global.WIDTH / 2 - 64);
	y = clamp(y, 64, room_height - global.HEIGHT / 2 - 64);
	
	global.editX = x;
	global.editY = y;
}

var CANG = dcos(global.screenAngle),
	SANG = dsin(global.screenAngle),
	vm = matrix_build_lookat(x, y, -100, x, y, 0, SANG, CANG, 0);

camera_set_view_mat(cam, vm);
