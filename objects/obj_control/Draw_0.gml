/// @description Draw Editor Grid

if (global.edit)
{
	if (showGrid)
	{
		var maxi = ceil((room_width - global.WIDTH / 2) / 16) * 16,
			maxj = ceil((room_height - global.HEIGHT / 2) / 16) * 16;
		
		draw_set_color($000000);
		draw_set_alpha(0.01);
		
		for (var i = 0; i < maxi + 16; i += 16)
		{
			for (var j = 0; j < maxj + 16; j += 16)
			{
				draw_line_width(-2, j - 1, maxi, j - 1, 2);
				draw_line_width(i - 1, -2, i - 1, maxj, 2);
			}
		}
		
		draw_set_color($FFFFFF);
		draw_set_alpha(1.0);
	}
}