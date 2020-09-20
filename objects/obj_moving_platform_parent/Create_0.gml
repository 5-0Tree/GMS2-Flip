/// @description Init

event_inherited();

canFall = false;

startCon = "Player Over";
atEnd = false;

wpID = noone;
wpPoint = 0;

var _o = collision_point(x, y, obj_waypoint, false, true);

if (_o != noone)
{
	with (_o)
	{
		if (_o.wpType == 1)
		{
			other.wpID = _o;
		}
	
		if (_o.wpType == 2)
		{
			other.atEnd = true;
		}
	}
}
