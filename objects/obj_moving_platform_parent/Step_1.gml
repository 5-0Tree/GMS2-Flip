/// @description Follow Path

var sw = sprite_width,
	sh = sprite_height,
	_c = collision_point(x - sw / 1.5 * dsin(global.angleFix), y - sh / 1.5 * dcos(global.angleFix), obj_player, false, true),
	_o = collision_point(x, y, obj_waypoint, false, true);

if (!init)
{
	if (_o != noone)
	{
		with (_o)
		{
			if (_o.wpType == 1)
			{
				other.wp = _o;
			}
			
			if (_o.wpType == 2)
			{
				other.atEnd = true;
			}
		}
		
		init = true;
	}
}

if (!global.edit)
{
	if (startCon == "Player Over")
	{
		if (_c != noone)
		{
			canMove = true;
		}
	}
}

if (canMove && wp != noone && !atEnd && !global.edit)
{
	with (wp)
	{
		var _s = other,
			_px = pl[_s.wpPoint][0],
			_py = pl[_s.wpPoint][1],
			_dir = point_direction(_s.x, _s.y, _px, _py);
		
		if (_s.x == _px && _s.y == _py)
		{
			_s.wpPoint ++;
			
			with (obj_waypoint)
			{
				if (wpType == 2)
				{
					if (x == _s.x && y == _s.y)
					{
						with (_s)
						{
							atEnd = true;
						}
					}
				}
			}
		}
		
		else
		{
			if (_c != noone)
			{
				with (_c)
				{
					if (!move)
					{
						_s.x += lengthdir_x(other.moveSpeed, _dir);
						_s.y += lengthdir_y(other.moveSpeed, _dir);
						
						x += lengthdir_x(other.moveSpeed, _dir);
						y += lengthdir_y(other.moveSpeed, _dir);
						
						image_index = 1;
						
						canMove = false;
						canFall = false;
					}
				}
			}
			
			else
			{
				_s.x += lengthdir_x(moveSpeed, _dir);
				_s.y += lengthdir_y(moveSpeed, _dir);
			}
		}
	}
	
	move = true;
}

if (atEnd)
{
	if (_c != noone)
	{
		with (_c)
		{
			image_index = 0;
			
			canMove = true;
			canFall = true;
		}
	}
	
	canMove = false;
	move = false;
}
