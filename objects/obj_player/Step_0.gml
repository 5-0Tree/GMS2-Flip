/// @description Move

if (fall)
{
	image_index = 1;
}

else if (canFall)
{
	image_index = 0;
}

if (image_index == 0 && !global.edit && ceil(floor(global.screenAngle + 0.5) - 0.5) mod 90 == 0)
{
	var dir = keyboard_check(vk_right) - keyboard_check(vk_left),
		af = global.angleFix,
		sw = sprite_width,
		sh = sprite_height,
		hw = sw / 2,
		hh = sh / 2,
		cc = collision_point(x + sw * dcos(image_angle), y - sh * dsin(image_angle), obj_wall_sp_c, false, true),
		cm = collision_point(x - sw * dcos(image_angle), y + sh * dsin(image_angle), obj_wall_sp_m, false, true);
	
	if (cc != noone)
	{
		with (cc)
		{
			if (dcos(-other.image_angle) == dcos(image_angle - 90) &&
				dsin(other.image_angle) == dsin(image_angle - 90))
			{
				if (room == rm_editor)
				{
					toggle_editor();
				}
				
				else
				{
					room_restart();
				}
			}
		}
	}
	
	if (cm != noone)
	{
		with (cm)
		{
			if (dcos(other.image_angle) == dcos(image_angle + 90) &&
				dsin(-other.image_angle) == dsin(image_angle - 90))
			{
				if (room == rm_editor)
				{
					toggle_editor();
				}
				
				else
				{
					room_restart();
				}
			}
		}
	}
	
	if (abs(dir) == 1 && !move)
	{
		var _x = x + dir * dcos(af) * sw,
			_y = y - dir * dsin(af) * sh,
			_c = collision_point(_x, _y, obj_collision_parent, false, true),
			go = true;
		
		with (_c)
		{
			go = false;
		}
		
		if (go)
		{
			if (a == 0)
			{
				move = true;
				
				a = dir;
				
				rot += a * 90;
				
				xO = x + hw * -(a * pow(dcos(af), abs(dcos(af))) * -pow(a * dsin(af), abs(dsin(af))));
				yO = y + hh * (a * pow(-dcos(af), abs(dcos(af))) * -a * pow(-a * -dsin(af), abs(dsin(af))));
			}
		}
	}
	
	if (abs(a) = 1)
	{
		image_angle -= moveSpeed * a;
			
		x = xO + r * dcos(image_angle + rot + 45 + sign(-a + 1) * 90 + af);
		y = yO - r * dsin(image_angle + rot + 45 + sign(-a + 1) * 90 + af);
		
		if (image_angle == defAng - a * rc * 90)
		{
			move = false;
			
			rot += a * (rc - 1) * 90;
			rc = 1;
			
			a = 0;
			defAng = image_angle;
			
			s = false;
		}
	}
}
