/// @description Draw Editor Interface

var _x = global.editX - global.WIDTH / 2,
	_y = global.editY - global.HEIGHT / 2,
	grid_x = floor(mouse_x / 16) * 16,
	grid_y = floor(mouse_y / 16) * 16,
	_sel = selObj;

if (global.edit)
{
	//surface_set_target(surfGUI);
	
	grid_x = clamp(grid_x, 64, room_width - global.WIDTH / 2 - 64);
	grid_y = clamp(grid_y, 64, room_height - global.HEIGHT / 2 - 64);
	
	if (mouse_x < _x + 56 && mouse_y > _y + 16)
	{
		scroll[selCat] += (mouse_wheel_up() - mouse_wheel_down()) * 4;
	}
	
	scroll[selCat] = clamp(scroll[selCat], -max(0, ceil(array_length(variable_struct_get(objs, objNames[selCat])) / 2 + 1) * 24 - global.HEIGHT), 0);
	
	if (point_in_rectangle(mouse_x, mouse_y, _x + 54 * global.expanded, _y + global.HEIGHT / 2 - 4,
	 _x + 54 * global.expanded + 6, _y + global.HEIGHT / 2 + 4))
	{
		if (mouse_check_button(mb_left))
		{
			expandPressed = true;
		}
		
		else if (mouse_check_button_released(mb_left))
		{
			global.expanded = !global.expanded;
		}
		
		else
		{
			expandPressed = false;
		}
	}
	
	else
	{
		expandPressed = false;
	}
	
	if (mouse_x > 58 * global.expanded + global.editX - global.WIDTH / 2 && !keyboard_check(vk_control) && !keyboard_check(vk_space) && !expandPressed)
	{
		if (object_exists(selObj))
		{
			if (selObj = obj_waypoint)
			{
				with (obj_waypoint)
				{
					if (wpID == other.wpID)
					{
						if (wpNum == other.wpNum - 1)
						{
							if (abs(x - mouse_x) < abs(y - mouse_y))
							{
								grid_x = x - 8;
							}
							
							else
							{
								grid_y = y - 8;
							}
						}
					}
				}
			}
			
			draw_sprite_ext(object_get_sprite(selObj), 0, grid_x + 8, grid_y + 8, 1, 1, angle, $FFFFFF, 1);
		
			if ((mouse_check_button_pressed(mb_left) && selObj == obj_waypoint) ^^ (mouse_check_button(mb_left) && selObj != obj_waypoint))
			{
				var can_place = false,
					_ds = ds_list_create();
				
				if (collision_point(grid_x + 8, grid_y + 8, obj_object_parent, false, true) != noone)
				{
					if (selObj == obj_waypoint)
					{
						if (collision_point(grid_x + 8, grid_y + 8, obj_waypoint, false, true) != noone)
						{
							can_place = false;
						}
						
						else
						{
							can_place = true;
						}
					}
					
					else
					{
						collision_point_list(grid_x + 8, grid_y + 8, obj_object_parent, false, true, _ds, false);
						
						for (var i = 0; i < ds_list_size(_ds); i ++)
						{
							if (i < 1)
							{
								if (_ds[| i].object_index == obj_waypoint)
								{
									can_place = true;
								}
							}
						}
					}
				}
				
				else
				{
					can_place = true;
				}
				
				if (ds_list_size(_ds) > 0)
				{
					if (_ds[| 0].object_index == obj_spikes)
					{
						can_place = true;
					}
				}
				
				ds_list_destroy(_ds);
				
				if (can_place)
				{
					with (instance_create_layer(grid_x + 8, grid_y + 8, "Objects", selObj))
					{
						var id_arr = [id],
							_b = false,
							_iswp = false;
						
						if (object_index == obj_waypoint)
						{
							_iswp = true;
							
							wpID = other.wpID;
							wpNum = other.wpNum;
							wpType = other.wpType;
							
							with (obj_waypoint)
							{
								if (wpID == other.wpID)
								{
									if (wpType == 1)
									{
										pl[other.wpNum] = [other.x, other.y];
									}
								}
							}
							
							other.wpNum ++;
							
							if (other.wpType == 1)
							{
								other.wpType = 0;
							}
							
							for (var i = 0; i < instance_number(obj_waypoint); i ++)
							{
								with (instance_find(obj_waypoint, i))
								{
									if (wpID == other.wpID)
									{
										id_arr[i] = id;
									}
								}
							}
							
							other.wpPlace = id_arr;
						}
						
						image_angle = other.angle;
						
						if (object_index == obj_spikes)
						{
							var _ds = ds_list_create();
							
							collision_point_list(x, y, obj_spikes, false, true, _ds, false);
							
							for (var i = 0; i < ds_list_size(_ds); i ++)
							{
								with (_ds[| i])
								{
									if (dsin(image_angle) == dsin(other.image_angle) && dcos(image_angle) == dcos(other.image_angle))
									{
										instance_destroy(other);
									
										_b = true;
									}
								}
							}
							
							ds_list_destroy(_ds);
						}
						
						if (object_index == obj_player)
						{
							defAng = image_angle;
							
							rot = -defAng;
						}
						
						a_origin = image_angle;
						x_origin = x;
						y_origin = y;
						
						if (!_b)
						{
							global.hist[global.hNum + _iswp] = ["Add", id_arr];
							
							if (!_iswp)
							{
								global.hNum ++;
							}
							
							array_resize(global.hist, global.hNum);
						}
						
						other.lchanged = true;
					}
				}
			}
		}
		
		if (mouse_check_button(mb_right))
		{
			var _ds = ds_list_create(),
				id_arr = [];
			
			collision_point_list(grid_x + 8, grid_y + 8, obj_object_parent, false, true, _ds, false);
			
			for (var i = 0; i < ds_list_size(_ds); i ++)
			{
				with (_ds[| i])
				{
					if (i < 1)
					{
						id_arr = [id];
					}
					
					if (object_get_parent(object_index) == obj_moving_platform_parent)
					{
						continue;
					}
					
					//Work on: Moving PLatform deletion...
					
					if (object_index == obj_waypoint)
					{
						with (obj_moving_platform_parent)
						{
							if (place_meeting(x, y, other))
							{
								continue;
							}
						}
						
						other.wpID ++;
						other.wpNum = 0;
						other.wpType = 1;
						other.wpPlace = [];
						
						for (var j = 0; j < instance_number(obj_waypoint); j ++)
						{
							with (instance_find(obj_waypoint, j))
							{
								if (wpID == other.wpID)
								{
									id_arr[j] = id;
								}
							}
						}
					}
					
					if (object_index == obj_spikes)
					{
						if (ds_list_size(_ds) > 1)
						{
							id_arr[i] = id;
							
							if (i < ds_list_size(_ds) - 1)
							{
								continue;
							}
						}
					}
					
					global.hist[global.hNum] = ["Delete", id_arr];
					global.hNum ++;
					
					array_resize(global.hist, global.hNum);
					
					for (var i = 0; i < array_length(id_arr); i ++)
					{
						instance_deactivate_object(id_arr[i]);
					}
					
					other.lchanged = true;
				}
			}
			
			ds_list_destroy(_ds);
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
		yy = 32 + scroll[selCat];
	
	if (global.expanded)
	{
		draw_set_color($FFFFFF);
		draw_set_alpha(0.5);
		
		draw_rectangle(_x, _y, _x + 56, _y + global.HEIGHT, false);
		
		draw_set_alpha(1.0);
		
		draw_rectangle(_x, _y, _x + 57, _y + global.HEIGHT, true);
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
						if (selObj != variable_struct_get(objs, objNames[selCat])[o])
						{
							selObj = variable_struct_get(objs, objNames[selCat])[o];
						}
						
						else
						{
							selObj = -1;
						}
					}
					
					draw_roundrect_ext(_x + xx - 10, _y + yy - 10, _x + xx + 8, _y + yy + 8, 1, 1, true);
				
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
					
					draw_roundrect_ext(_x + xx - 10, _y + yy - 10, _x + xx + 8, _y + yy + 8, 1, 1, false);
					
					draw_set_alpha(0.8);
					
					draw_roundrect_ext(_x + xx - 10, _y + yy - 10, _x + xx + 8, _y + yy + 8, 1, 1, true);
					
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
	
	draw_rectangle(_x + 54 * global.expanded, _y + global.HEIGHT / 2 - 5, _x + 54 * global.expanded + 6, _y + global.HEIGHT / 2 + 4, false);
	draw_sprite_ext(spr_arrow, expandPressed, _x + global.expanded * 53 + 4, _y + global.HEIGHT / 2, expandDir, 1, 0, $FFFFFF, 1);
	
	if (keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_f2) || _sel != selObj || mouse_check_button_pressed(mb_right))
	{
		with (obj_waypoint)
		{
			if (wpID == obj_editor_control.wpID)
			{
				if (wpNum == obj_editor_control.wpNum - 1)
				{
					wpType = 2;
					
					obj_editor_control.wpID ++;
					obj_editor_control.wpNum = 0;
					obj_editor_control.wpType = 1;
					
					if (array_length(obj_editor_control.wpPlace) > 0)
					{
						global.hist[global.hNum][0] = "Add";
						global.hist[global.hNum][1] = obj_editor_control.wpPlace;
					}
					
					global.hNum ++;
					
					obj_editor_control.wpPlace = [];
				}
			}
		}
	}
	
	if (global.expanded)
	{
		var hover_l = false,
			hover_r = false;
		
		draw_set_font(font_main);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
		draw_rectangle(_x, _y, _x + 55, _y + 16, false);
		
		draw_set_color($282828);
		
		draw_text(_x + 28, _y + 9, objNames[selCat]);
		
		draw_set_color($FFFFFF);
		
		//Left button
		if (selCat > 0)
		{
			if (point_in_rectangle(mouse_x, mouse_y, _x + 4, _y + 4, _x + 9, _y + 12))
			{
				if (mouse_check_button_pressed(mb_left))
				{
					selCat --;
				}
				
				hover_l = true;
			}
			
			else
			{
				hover_l = false;
			}
			
			draw_sprite_ext(spr_arrow, hover_l, _x + 6, _y + 8, -1, 1, 0, $FFFFFF, 1);
		}
		
		//Right button
		if (selCat < array_length(objNames) - 1)
		{
			if (point_in_rectangle(mouse_x, mouse_y, _x + 47, _y + 4, _x + 52, _y + 12))
			{
				if (mouse_check_button_pressed(mb_left))
				{
					selCat ++;
				}
				
				hover_r = true;
			}
			
			else
			{
				hover_r = false;
			}
			
			draw_sprite_ext(spr_arrow, hover_r, _x + 50, _y + 8, 1, 1, 0, $FFFFFF, 1);
		}
	}
	
	//draw_clear_alpha($FFFFFF, 0);
	
	//surface_reset_target();
}

if (keyboard_check_pressed(vk_f2))
{
	toggle_editor();
}
