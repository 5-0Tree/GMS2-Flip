/// @description Draw Editor Interface

var _x = global.editX - global.WIDTH / 2,
	_y = global.editY - global.HEIGHT / 2,
	_x2 = global.editX + global.WIDTH / 2,
	_y2 = global.editY + global.HEIGHT / 2,
	grid_x = floor(mouse_x / 16) * 16,
	grid_y = floor(mouse_y / 16) * 16,
	_sel = selObj;

if (global.edit)
{
	//surface_set_target(surfGUI);
	
	grid_x = floor(clamp(grid_x, 0, room_width - global.WIDTH / 2) / 16) * 16;
	grid_y = floor(clamp(grid_y, 0, room_height - global.HEIGHT / 2) / 16) * 16;
	
	if (mouse_x < _x + 56 && mouse_y > _y + 16)
	{
		scroll[selCat] += (mouse_wheel_up() - mouse_wheel_down()) * 4;
	}
	
	scroll[selCat] = clamp(scroll[selCat], -max(0, ceil(array_length(variable_struct_get(objs, objNames[selCat])) / 2 + 1) * 24 - global.HEIGHT), 0);
	
	if (point_in_rectangle(mouse_x, mouse_y, _x + 54 * global.expanded, global.editY - 4, _x + 54 * global.expanded + 6, global.editY + 4) && !altMenu)
	{
		if (mouse_check_button_pressed(mb_left))
		{
			expandPressed = true;
			
			clickingButton = true;
		}
		
		if (mouse_check_button_released(mb_left))
		{
			global.expanded = !global.expanded;
		}
	}
	
	else
	{
		expandPressed = false;
	}
	
	if (!mouse_check_button(mb_left))
	{
		expandPressed = false;
		
		clickingButton = false;
	}
	
	if (mouse_x > 58 * global.expanded + _x && !(mouse_x > _x2 - 40 && mouse_y > _y2 - 16) &&
	 !keyboard_check(vk_space) && !expandPressed && !clickingButton)
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
			
			if (!altMenu && !keyboard_check(vk_control))
			{
				draw_sprite_ext(object_get_sprite(selObj), 0, grid_x + 8, grid_y + 8, 1, 1, angle, $FFFFFF, 1);
				
				if ((mouse_check_button_pressed(mb_left) && selObj == obj_waypoint) ^^ (mouse_check_button(mb_left) && selObj != obj_waypoint))
				{
					with (obj_object_parent)
					{
						selected = false;	
					}
					
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
								if (_ds[| i].object_index == obj_waypoint)
								{
									can_place = true;
								}
								
								else
								{
									can_place = false;
									
									break;
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
								_p = false;
							
							if (object_index == obj_waypoint)
							{
								_p = true;
								
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
								
								with (obj_waypoint)
								{
									if (wpID == other.wpID)
									{
										id_arr[obj_editor_control.wpN] = id;
										
										obj_editor_control.wpN ++;
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
							
							editLayer = max(0, global.Layer);
							
							a_origin = image_angle;
							x_origin = x;
							y_origin = y;
							
							if (!_b)
							{
								global.hist[global.hNum] = ["Add", id_arr];
								
								if (!_p)
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
		}
		
		if (selObj == -1 && keyboard_check(vk_alt))
		{
			if (mouse_check_button_pressed(mb_left))
			{
				var _go = false;
				
				with (collision_point(mouse_x, mouse_y, obj_object_parent, false, true))
				{
					if (selected)
					{
						_go = true;
					}
				}
				
				if (_go)
				{
					altMenu = true;
				}
			}
		}
		
		if (keyboard_check(vk_control))
		{
			if (mouse_check_button_pressed(mb_left))
			{
				selectX = mouse_x + 1;
				selectY = mouse_y + 1;
			}
			
			if (mouse_check_button(mb_left))
			{
				draw_set_color($00FF00);
				draw_set_alpha(0.5);
				
				draw_rectangle(selectX, selectY, mouse_x - 1, mouse_y - 1, false);
				
				draw_set_alpha(1.0);
				
				draw_rectangle(selectX, selectY, mouse_x - 1, mouse_y - 1, true);
				
				draw_set_color($FFFFFF);
				
				with (obj_object_parent)
				{
					selected = false;
				}
				
				var _ds = ds_list_create();
				
				collision_rectangle_list(selectX, selectY, mouse_x, mouse_y, obj_object_parent, false, true, _ds, false);
				
				for (var i = 0; i < ds_list_size(_ds); i ++)
				{
					with (_ds[| i])
					{
						selected = true;
					}
				}
				
				ds_list_destroy(_ds);
			}
		}
		
		if (mouse_check_button(mb_right) && !altMenu)
		{
			var _ds = ds_list_create(),
				_b = false,
				id_arr = [];
			
			collision_point_list(mouse_x, mouse_y, obj_object_parent, false, true, _ds, true);
			
			for (var i = 0; i < ds_list_size(_ds); i ++)
			{
				with (_ds[| i])
				{
					id_arr = [id];
					
					//Work on: Moving PLatform deletion...
					
					if (object_index == obj_waypoint)
					{
						with (obj_moving_platform_parent)
						{
							if (collision_point(mouse_x, mouse_y, other, false, true) != noone)
							{
								global.go = false;
								
								break;
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
					
					if (global.go && (editLayer == global.Layer || global.Layer < 0))
					{
						global.hist[global.hNum] = ["Delete", id_arr];
						global.hNum ++;
						
						array_resize(global.hist, global.hNum);
						
						for (var j = 0; j < array_length(id_arr); j ++)
						{
							instance_deactivate_object(id_arr[j]);
						}
						
						other.lchanged = true;
					}
				}
				
				if (_b)
				{
					global.go = false;
						
					break;
				}
			}
			
			ds_list_destroy(_ds);
		}
		
		if (mouse_check_button_released(mb_right))
		{
			global.go = true;
		}
	}
	
	if (!mouse_check_button(mb_left))
	{
		selectX = mouse_x + 1;
		selectY = mouse_y + 1;
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
				if (point_in_rectangle(mouse_x, mouse_y, _x + xx - 8, _y + yy - 8, _x + xx + 8, _y + yy + 8) && !altMenu)
				{
					draw_set_color($FFDEAA);
					draw_set_alpha(0.8);
					
					if (mouse_check_button_pressed(mb_left) && !altMenu)
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
					
					draw_rectangle(_x + xx - 10, _y + yy - 10, _x + xx + 10, _y + yy + 10, true);
					
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
					
					draw_rectangle(_x + xx - 9, _y + yy - 9, _x + xx + 9, _y + yy + 9, false);
					
					draw_set_alpha(0.8);
					
					draw_rectangle(_x + xx - 9, _y + yy - 9, _x + xx + 9, _y + yy + 9, true);
					
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
					
					obj_editor_control.wpN = 0;
					obj_editor_control.wpPlace = [];
				}
			}
		}
	}
	
	if (global.expanded)
	{
		draw_set_font(font_main);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
		var hover_l = false,
			hover_r = false;
		
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
	
	draw_set_font(font_main);
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);
	
	var hover_l = false,
		hover_r = false,
		_txt = string(global.Layer),
		_w = string_width(string(global.Layer));
	
	if (global.Layer < 0)
	{
		_txt = "All";
	}
	
	draw_rectangle(_x2, _y2, _x2 - 39, _y2 - 15, true);
	draw_rectangle(_x2, _y2, _x2 - 40, _y2 - 16, true);
	draw_rectangle(_x2, _y2, _x2 - 41, _y2 - 17, true);
	
	draw_set_alpha(0.5);
	
	draw_rectangle(_x2, _y2, _x2 - 40, _y2 - 16, false);
	
	draw_set_color($000000);
	
	draw_text(_x2 - 9, _y2 - 5, _txt);
	
	draw_set_color($FFFFFF);
	draw_set_alpha(1.0);
	
	draw_text(_x2 - 10, _y2 - 6, _txt);
	
	//Left button
	if (global.Layer >= 0)
	{
		if (point_in_rectangle(mouse_x, mouse_y, _x2 - _w - 18, _y2 - 10, _x2 - _w - 13, _y2 - 2))
		{
			if (mouse_check_button_pressed(mb_left))
			{
				global.Layer --;
			}
			
			hover_l = true;
		}
		
		else
		{
			hover_l = false;
		}
		
		if (keyboard_check_pressed(vk_left))
		{
			global.Layer --;
		}
		
		draw_sprite_ext(spr_arrow, hover_l, _x2 - _w - 15, _y2 - 6, -1, 1, 0, $FFFFFF, 1);
	}
	
	//Right button
	if (global.Layer < global.maxLayer)
	{
		if (point_in_rectangle(mouse_x, mouse_y, _x2 - 9, _y2 - 10, _x2 - 4, _y2 - 2))
		{
			if (mouse_check_button_pressed(mb_left))
			{
				global.Layer ++;
			}
			
			hover_r = true;
		}
		
		else
		{
			hover_r = false;
		}
		
		if (keyboard_check_pressed(vk_right))
		{
			global.Layer ++;
		}
		
		draw_sprite_ext(spr_arrow, hover_r, _x2 - 6, _y2 - 6, 1, 1, 0, $FFFFFF, 1);
	}
	
	with (obj_object_parent)
	{
		if (global.Layer > -1)
		{
			if (editLayer == global.Layer)
			{
				image_alpha = 1;
			}
			
			else
			{
				image_alpha = 0.5;
			}
		}
		
		else
		{
			image_alpha = 1;
		}
	}
	
	if (altMenu)
	{
		draw_rectangle(_x + 32, _y, _x2 - 32, _y2, false);
		
		var col = true,
			ang = true,
			alp = true,
			grp = true,
			lay = true,
			loc = true,
			con = true,
			spe = true,
			trg = true,
			vnm = 0,
			bar = [],
			car = ["Color", "Angle", "Alpha", "Group", "Layer", "Locked", "Condition", "Speed", "Trigger"];
		
		with (obj_object_parent)
		{
			/*
			Main : {
				Color : undefined,
				Angle : undefined,
				Alpha : undefined,
				Group : undefined,
				Layer : undefined
			},
			Active : {
				Locked : undefined,
				Condition : undefined,
				Speed : undefined,
				Trigger : undefined
			}
			*/
			
			if (selected)
			{
				if (accAttr.Main.Color == undefined && col)
				{
					col = false;
				}
				
				else
				{
					bar[vnm] = accAttr.Main.Color;
					vnm ++;
				}
				
				if (accAttr.Main.Angle == undefined && ang)
				{
					ang = false;
				}
				
				else
				{
					bar[vnm] = accAttr.Main.Angle;
					vnm ++;
				}
				
				if (accAttr.Main.Alpha == undefined && alp)
				{
					alp = false;
				}
				
				else
				{
					bar[vnm] = accAttr.Main.Alpha;
					vnm ++;
				}
								
				if (accAttr.Main.Color == undefined && grp)
				{
					grp = false;
				}
				
				else
				{
					bar[vnm] = accAttr.Main.Group;
					vnm ++;
				}
				
				if (accAttr.Main.Layer == undefined && lay)
				{
					lay = false;
				}
				
				else
				{
					bar[vnm] = accAttr.Main.Layer;
					vnm ++;
				}
				
				if (accAttr.Active.Locked == undefined && loc)
				{
					loc = false;
				}
				
				else
				{
					bar[vnm] = accAttr.Active.Locked;
					vnm ++;
				}
				
				if (accAttr.Active.Condition == undefined && con)
				{
					con = false;
				}
				
				else
				{
					bar[vnm] = accAttr.Active.Condition;
					vnm ++;
				}
				
				if (accAttr.Active.Speed == undefined && spe)
				{
					spe = false;
				}
				
				else
				{
					bar[vnm] = accAttr.Active.Speed;
					vnm ++;
				}
				
				if (accAttr.Active.Trigger == undefined && trg)
				{
					trg = false;
				}
				
				else
				{
					bar[vnm] = accAttr.Active.Trigger;
					vnm ++;
				}
			}
		}
		
		//Work on alt menu...
		
		var aar = [col, ang, alp, grp, lay, loc, con, spe, trg],
			__n = 0;
		
		draw_set_halign(fa_left);
		draw_set_color($000000);
		
		for (var i = 0; i < array_length(aar); i ++)
		{
			if (aar[i])
			{
				draw_text(_x + 48, _y + 16 + (i - __n) * 12, car[i]);
			}
			
			else
			{
				__n ++;
			}
		}
		
		draw_set_color($FFFFFF);
		
		if (keyboard_check_pressed(vk_escape))
		{
			altMenu = false;
		}
	}
	
	//draw_clear_alpha($FFFFFF, 0);
	
	//surface_reset_target();
}

if (keyboard_check_pressed(vk_f2))
{
	toggle_editor();
}
