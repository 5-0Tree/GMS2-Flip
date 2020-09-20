/// @description Movement

if (movable)
{
	if (ceil(floor(global.screenAngle + 0.5) - 0.5) mod 90 == 0)
	{
		if (!place_meeting(x - lengthdir_y(4, global.angleFix),
		 y + lengthdir_x(4, global.angleFix), obj_collision_parent))
		{
			if (canFall)
			{
				x -= lengthdir_y(4, global.angleFix);
				y += lengthdir_x(4, global.angleFix);
				
				fall = true;
			}
		}
		
		else
		{
			fall = false;
		}
	}
}
