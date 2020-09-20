/// @description Camera Movement

global.screenAngle += ((global.angleFix - global.screenAngle) / global.screenRotSpd);

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

if (!global.edit)
{
	if (instance_number(obj_player) == 1)
	{
		xTo = obj_player.x;
		yTo = obj_player.y;
	}
}

else
{
	xTo = global.editX + WIDTH / 2 * ZOOM;
	yTo = global.editY + HEIGHT / 2 * ZOOM;
}

var CANG = dcos(global.screenAngle),
	SANG = dsin(global.screenAngle);

var vm = matrix_build_lookat(x, y, -100, x, y, 0, SANG, CANG, 0);

camera_set_view_mat(cam, vm);
