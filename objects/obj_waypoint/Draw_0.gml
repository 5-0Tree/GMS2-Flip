/// @description Draw Dots

var sw = sprite_width,
	sh = sprite_height;

if (wpType == 1 && init)
{
	for (var _n = 0; _n < wpNum; _n ++)
	{
		for (var i = x; i < pl[_n][0]; i += sw)
		{
			for (var j = y; j < pl[_n][1]; j += sh)
			{
				draw_sprite_ext(spr_waypoint, 3, i, j,
				 1, 1, image_angle, $FFFFFF, image_alpha);
			}
		}
	}
}

draw_self();
