/// @description Update

image_angle = global.screenAngle;
image_index = wpType;

var _n = wpNum;

if (wpType == 1)
{
	var _w = obj_waypoint;
	
	with (_w)
	{
		if (ID == other.ID)
		{
			if (wpNum == other.wpNum + 1)
			{
				other.pl[wpNum] = [x, y];
				
				other.wpNum ++;
			}
		}
	}
}

if (_n == wpNum)
{
	init = true;
}
