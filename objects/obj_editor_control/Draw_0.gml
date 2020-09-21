/// @description Draw Editor Interface

//surface_set_target(surfGUI);

var _x = global.editX - global.WIDTH / 2,
	_y = global.editY - global.HEIGHT / 2,
	grid_x = floor(mouse_x / 16) * 16,
	grid_y = floor(mouse_y / 16) * 16;

grid_x = clamp(grid_x, 64, room_width - global.WIDTH / 2 - 64);
grid_y = clamp(grid_y, 64, room_height - global.HEIGHT / 2 - 64);

if (mouse_x > 56 * global.expanded + global.editX - global.WIDTH / 2)
{
	if (object_exists(selObj))
	{
		draw_sprite(object_get_sprite(selObj), 0, grid_x + 8, grid_y + 8);
	}
}

if (point_in_rectangle(mouse_x, mouse_y, _x + 52 * global.expanded, _y + global.HEIGHT / 2 - 5,
 _x + 52 * global.expanded + 9, _y + global.HEIGHT / 2 + 4))
{
	if (mouse_check_button_pressed(mb_left))
	{
		global.expanded = !global.expanded
	}
}

if (global.expanded)
{
	expandDir = -1;
}

else
{
	expandDir = 1;
}

var o = 0,
	yy = 16;

if (global.expanded)
{
	draw_set_color($FFFFFF);
	draw_set_alpha(0.8);
	
	draw_rectangle(_x, _y, _x + 56, _y + global.HEIGHT, false);
	
	draw_set_alpha(1.0);
	
	draw_rectangle(_x, _y, _x + 56, _y + global.HEIGHT, true);
	draw_rectangle(_x, _y, _x + 55, _y + global.HEIGHT, true);
	
	for (var xx = 16; xx < 56; xx += 24)
	{
		var _so = false;
		
		if (o < array_length(variable_struct_get(objs, objNames[selCat])))
		{
			if (point_in_rectangle(mouse_x, mouse_y, _x + xx - 8, _y + yy - 8, _x + xx + 8, _y + yy + 8))
			{
				draw_set_color($FFDEAA);
				draw_set_alpha(0.8);
				
				if (mouse_check_button_pressed(mb_left))
				{
					selObj = variable_struct_get(objs, objNames[selCat])[o];
				}
				
				draw_roundrect_ext(_x + xx - 10, _y + yy - 10, _x + xx + 9, _y + yy + 8, 1, 1, true);
				
				draw_set_color($FFFFFF);
				draw_set_alpha(1.0);
			}
			
			if (selObj == variable_struct_get(objs, objNames[selCat])[o])
			{
				_so = true;
			}
			
			if (_so)
			{
				draw_set_color($FFDEAA);
				draw_set_alpha(0.6);
				
				draw_roundrect_ext(_x + xx - 10, _y + yy - 10, _x + xx + 9, _y + yy + 8, 1, 1, false);
				
				draw_set_alpha(0.8);
				
				draw_roundrect_ext(_x + xx - 10, _y + yy - 10, _x + xx + 9, _y + yy + 8, 1, 1, true);
				
				draw_set_color($FFFFFF);
				draw_set_alpha(1.0);
			}
			
			draw_sprite(object_get_sprite(variable_struct_get(objs, objNames[selCat])[o]), 0, _x + xx, _y + yy);
			
			if (xx >= 32)
			{
				xx = -8;
				yy += 24;
			}
			
			o ++;
		}
	}
}

draw_rectangle(_x + 52 * global.expanded, _y + global.HEIGHT / 2 - 5, _x + 52 * global.expanded + 7, _y + global.HEIGHT / 2 + 4, false);
draw_sprite_ext(spr_arrow, 0, _x + global.expanded * 52 + 4, _y + global.HEIGHT / 2, expandDir, 1, 0, $FFFFFF, 1);

//draw_clear_alpha($FFFFFF, 0);

//surface_reset_target();
