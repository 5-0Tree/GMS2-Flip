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
	x = clamp(x, 0, room_width - global.WIDTH / 2);
	y = clamp(y, 0, room_height - global.HEIGHT / 2);
	
	global.editX = x;
	global.editY = y;
}

var CANG = floor(dcos(global.screenAngle) * 100) / 100,
	SANG = floor(dsin(global.screenAngle) * 100) / 100,
	vm = matrix_build_lookat(x, y, -100, x, y, 0, SANG, CANG, 0);

camera_set_view_mat(cam, vm);
