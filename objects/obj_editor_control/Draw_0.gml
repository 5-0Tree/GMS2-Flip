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
	
	if (point_in_rectangle(mouse_x, mouse_y, _x + 54 * global.expanded, global.editY - 4, _x + 54 * global.expanded + 6, global.editY + 4) && !altMenu && !open && !saveAs)
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
			
			if (!keyboard_check(vk_control) && !altMenu && !open && !saveAs)
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
					
					if (ds_list_size(_ds) == 1)
					{
						if (_ds[| 0].object_index == obj_spikes)
						{
							can_place = true;
						}
					}
					
					ds_list_destroy(_ds);
					
					if (can_place && global.go)
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
								
								var in = 0;
								
								with (obj_waypoint)
								{
									if (wpID == other.wpID)
									{
										id_arr[in] = id;
										
										in ++;
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
		
		if (selObj == -1)
		{
			if (mouse_check_button_pressed(mb_left))
			{
				if (keyboard_check(vk_alt))
				{
					var _go = false;
					
					with (collision_point(mouse_x, mouse_y, obj_object_parent, false, true))
					{
						if (selected)
						{
							_go = true;
						}
					}
					
					if (_go && !keyboard_check(vk_shift))
					{
						altMenu = true;
					}
				}
				
				else if (!keyboard_check(vk_shift) && !altMenu && !open && !saveAs)
				{
					with (obj_object_parent)
					{
						selected = false;
					}
				}
			}
		}
		
		if (keyboard_check(vk_shift))
		{
			if (mouse_check_button_pressed(mb_left))
			{
				selectX = mouse_x + 1;
				selectY = mouse_y + 1;
			}
			
			if (selObj == -1)
			{
				if (mouse_check_button(mb_left))
				{
					draw_set_color($00FF00);
					draw_set_alpha(0.5);
					
					draw_rectangle(selectX, selectY, mouse_x - 1, mouse_y - 1, false);
					
					draw_set_alpha(1.0);
					
					draw_rectangle(selectX, selectY, mouse_x - 1, mouse_y - 1, true);
					
					draw_set_color($FFFFFF);
					
					if (!keyboard_check(vk_alt))
					{
						with (obj_object_parent)
						{
							selected = false;
						}
					}
					
					var _ds = ds_list_create();
					
					collision_rectangle_list(selectX, selectY, mouse_x, mouse_y, obj_object_parent, false, true, _ds, false);
					
					for (var i = 0; i < ds_list_size(_ds); i ++)
					{
						with (_ds[| i])
						{
							if (editLayer == global.Layer || global.Layer == -1)
							{
								selected = true;
							}
						}
					}
					
					ds_list_destroy(_ds);
				}
			}
		}
		
		if (mouse_check_button(mb_right) && !altMenu && !open && !saveAs)
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
					
					if (object_index == obj_waypoint)
					{
						other.wpID ++;
						other.wpNum = 0;
						other.wpType = 1;
						other.wpPlace = [];
						
						var in = 0;
						
						with (obj_waypoint)
						{
							if (wpID == other.wpID)
							{
								id_arr[in] = id;
								
								in ++;
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
				if (point_in_rectangle(mouse_x, mouse_y, _x + xx - 8, _y + yy - 8, _x + xx + 8, _y + yy + 8) && !altMenu && !open && !saveAs)
				{
					draw_set_color($FFDEAA);
					draw_set_alpha(0.8);
					
					if (mouse_check_button_pressed(mb_left) && !altMenu && !open && !saveAs)
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
					
					draw_rectangle(_x + xx - 9, _y + yy - 9, _x + xx + 8, _y + yy + 8, true);
					
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
					
					draw_rectangle(_x + xx - 9, _y + yy - 9, _x + xx + 8, _y + yy + 8, false);
					
					draw_set_alpha(0.8);
					
					draw_rectangle(_x + xx - 9, _y + yy - 9, _x + xx + 8, _y + yy + 8, true);
					
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
	
	if (!altMenu && !open && !saveAs)
	{
		if (keyboard_check_pressed(ord("V")))
		{
			selObj = -1;
		}
	}
	
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
				if (!altMenu && !open && !saveAs)
				{
					if (mouse_check_button_pressed(mb_left))
					{
						selCat --;
					}
					
					hover_l = true;
				}
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
				if (!altMenu && !open && !saveAs)
				{
					if (mouse_check_button_pressed(mb_left) && !altMenu && !open && !saveAs)
					{
						selCat ++;
					}
					
					hover_r = true;
				}
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
			if (!altMenu && !open && !saveAs)
			{
				if (mouse_check_button_pressed(mb_left))
				{
					global.Layer --;
				}
				
				hover_l = true;
			}
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
			if (!altMenu && !open && !saveAs)
			{
				if (mouse_check_button_pressed(mb_left))
				{
					global.Layer ++;
				}
				
				hover_r = true;
			}
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
		if (!trgMenu)
		{
			draw_set_color($000000);
			draw_set_alpha(0.4);
			
			draw_rectangle(_x, _y, _x2, _y2, false);
			
			draw_set_color($FFFFFF);
			draw_set_alpha(1.0);
			
			draw_rectangle(_x + 32, _y, _x2 - 32, _y2, false);
		}
		
		var col = true,
			ang = true,
			alp = true,
			grp = true,
			lay = true,
			loc = true,
			con = true,
			spe = true,
			trg = true,
			aar = [col, ang, alp, grp, lay, loc, con, spe, trg],
			bar = ["Color", "Angle", "Alpha", "Group", "Layer", "Locked", "Condition", "Speed", "Trigger"];
		
		for (var i = 0; i < array_length(aar); i ++)
		{
			aar[i] = alt_edit(obj_object_parent, "Main", bar[i], aar[i]);
		}
		
		//Work on alt menu...
		
		var __n = 0;
		
		for (var i = 0; i < array_length(aar); i ++)
		{
			draw_set_color($000000);
			
			var g = false;
			
			if (array_length(aar[i]) > 0)
			{
				g = true;
			}
			
			if (g && aar[i][0] != -1 && !trgMenu)
			{
				var _v = undefined,
					_t = undefined;
				
				draw_set_halign(fa_left);
				
				draw_text(_x + 48, _y + 12 + (i - __n) * 16, bar[i]);
				
				draw_set_halign(fa_right);
				
				if (array_length(aar[i]) > 1)
				{
					for (var j = 0; j < array_length(aar[i]); j ++)
					{
						if (j > 0)
						{
							if (_v != aar[i][j])
							{
								_t = "Mixed";
								
								break;
							}
						}
						
						_v = aar[i][j];
					}
					
					if (_t != "Mixed")
					{
						_t = _v;
					}
				}
				
				else
				{
					_t = aar[i][0];
				}
				
				if (bar[i] == "Color")
				{
					if (colChg)
					{
						_t = selCol;
					}
					
					if (_t == "Mixed")
					{
						draw_text(_x2 - 51, _y + 13 + (i - __n) * 16, "?");
					}
					
					else
					{
						draw_set_color(_t);
						
						draw_rectangle(_x2 - 63, _y + 5 + (i - __n) * 16, _x2 - 49, _y + 19 + (i - __n) * 16, false);
					}
					
					if (point_in_rectangle(mouse_x, mouse_y, _x2 - 64, _y + 4 + (i - __n) * 16, _x2 - 48, _y + 20 + (i - __n) * 16) && !colMenu)
					{
						draw_set_color($FFDEAA);
						
						if (mouse_check_button_pressed(mb_left))
						{
							colMenu = true;
						}
					}
					
					else
					{
						draw_set_color($000000);
					}
					
					draw_rectangle(_x2 - 63, _y + 5 + (i - __n) * 16, _x2 - 49, _y + 19 + (i - __n) * 16, true);
					
					draw_set_color($FFFFFF);
				}
				
				else if (bar[i] == "Condition")
				{
					var tstr = _t;
					
					if (conChg)
					{
						tstr = selCon;
					}
					
					if (point_in_rectangle(mouse_x, mouse_y, _x2 - 50 - string_width(tstr), _y + 8 + (i - __n) * 16, _x2 - 48, _y + 14 + (i - __n) * 16) && !conMenu)
					{
						draw_set_color($FFDEAA);
						
						if (mouse_check_button_pressed(mb_left))
						{
							var iv = 0;
							
							with (obj_object_parent)
							{
								if (selected)
								{
									other.conTar[iv] = id;
									
									iv ++;
								}
							}
							
							conMenu = true;
						}
					}
					
					else
					{
						draw_set_color($000000);
					}
					
					draw_text(_x2 - 48, _y + 12 + (i - __n) * 16, tstr);
				}
				
				else if (bar[i] == "Trigger")
				{
					draw_sprite(spr_target, 0, _x2 - 56, _y + 12 + (i - __n) * 16);
					
					if (point_in_rectangle(mouse_x, mouse_y, _x2 - 64, _y + 4 + (i - __n) * 16, _x2 - 48, _y + 20 + (i - __n) * 16) && !trgMenu)
					{
						draw_set_color($FFDEAA);
						
						if (mouse_check_button_pressed(mb_left))
						{
							var iv = 0;
							
							with (obj_object_parent)
							{
								if (selected)
								{
									other.trgTar[iv] = ID;
									
									iv ++;
								}
							}
							
							trgMenu = true;
						}
					}
					
					else
					{
						draw_set_color($000000);
					}
					
					draw_rectangle(_x2 - 63, _y + 5 + (i - __n) * 16, _x2 - 49, _y + 19 + (i - __n) * 16, true);
					
				}
				
				else
				{
					if (bar[i] == "Locked")
					{
						if (_t)
						{
							_t = "True";
						}
						
						else
						{
							_t = "False";
						}
					}
					
					draw_text(_x2 - 48, _y + 12 + (i - __n) * 16, _t);
				}
			}
			
			else
			{
				__n ++;
			}
		}
		
		draw_set_color($FFFFFF);
		
		if (keyboard_check_pressed(vk_escape) && !colMenu && !conMenu)
		{
			with (obj_object_parent)
			{
				if (selected)
				{
					if (other.colChg)
					{
						color = other.selCol;
					}
					
					if (other.conChg)
					{
						cond = other.selCon;
					}
				}
			}
			
			selCol = $FFFFFF;
			colChg = false;
			
			selCon = "";
			conChg = false;
			
			altMenu = false;
		}
	}
	
	if (colMenu)
	{
		draw_set_color($000000);
		draw_set_alpha(0.4);
		
		draw_rectangle(_x, _y, _x2, _y2, false);
		
		draw_set_color($FFFFFF);
		draw_set_alpha(1.0);
		
		draw_rectangle(_x + 32, _y + 16, _x2 - 32, _y2 - 16, false);
		
		draw_circle(global.editX, global.editY, 8, false);
		
		if (point_in_circle(mouse_x, mouse_y, global.editX, global.editY, 8))
		{
			draw_set_color($FFDEAA);
			
			if (mouse_check_button_pressed(mb_left))
			{
				selCol = $FFFFFF;
				colChg = true;
				
				colMenu = false;
			}
		}
		
		else
		{
			draw_set_color($000000);
		}
		
		draw_circle(global.editX, global.editY, 8, true);
		
		for (var i = 1; i < 256; i += 17)
		{
			var cx = floor(global.editX + lengthdir_x(32, (i - 1) / 255 * 360 + 180)),
				cy = floor(global.editY + lengthdir_y(32, (i - 1) / 255 * 360 + 180)),
				ccol = make_color_hsv(i - 1, 255, 255);
			
			draw_circle_color(cx, cy, 5, ccol, ccol, false);
			
			if (point_in_circle(mouse_x, mouse_y, cx, cy, 5))
			{
				draw_set_color($FFDEAA);
				
				if (mouse_check_button_pressed(mb_left))
				{
					selCol = ccol;
					colChg = true;
					
					colMenu = false;
				}
			}
			
			else
			{
				draw_set_color($000000);
			}
			
			draw_circle(cx, cy, 5, true);
		}
		
		if (keyboard_check_pressed(vk_escape))
		{
			colMenu = false;
		}
		
	}
	
	if (conMenu)
	{
		draw_set_color($000000);
		draw_set_alpha(0.4);
		
		draw_rectangle(_x, _y, _x2, _y2, false);
		
		var conds = mainConds,
			tcond = [];
		
		for (var i = 0; i < array_length(conTar); i ++)
		{
			with (conTar[i])
			{
				tcond[i] = accConds;
			}
		}
		
		for (var i = 0; i < array_length(tcond); i ++)
		{
			for (var j = 0; j < array_length(tcond[i]); j ++)
			{
				if (tcond[i][j] == undefined)
				{
					conds[j] = undefined;
				}
			}
		}
		
		for (var i = 0; i < array_length(conds); i ++)
		{
			if (conds[i] == undefined)
			{
				array_delete(conds, i, 1);
			}
		}
		
		draw_set_color($FFFFFF);
		draw_set_alpha(1.0);
		
		draw_rectangle(_x + 48, global.editY - array_length(conds) * 8, _x2 - 48, global.editY + array_length(conds) * 8, false);
		
		draw_set_halign(fa_center);
		
		for (var i = 0; i < array_length(conds); i ++)
		{
			if (point_in_rectangle(mouse_x, mouse_y,
				global.editX - 1 - string_width(conds[i]) / 2, global.editY + 4 - array_length(conds) * 8 + i * 16,
				global.editX + string_width(conds[i]) / 2, global.editY + 12 - array_length(conds) * 8 + i * 16))
			{
				draw_set_color($FFDEAA);
				
				if (mouse_check_button_pressed(mb_left))
				{
					selCon = conds[i];
					conChg = true;
					
					conMenu = false;
				}
			}
			
			else
			{
				draw_set_color($000000);
			}
			
			draw_text(global.editX, global.editY + 9 - array_length(conds) * 8 + i * 16, conds[i]);
		}
		
		draw_set_color($FFFFFF);
		
		if (keyboard_check_pressed(vk_escape))
		{
			conMenu = false;
		}
	}
	
	if (trgMenu)
	{
		draw_set_color($FFFFFF);
		draw_set_alpha(1.0);
		
		draw_circle(_x2 - 8, _y + 8, 8, false);
		
		var hover = false;
		
		if (point_in_circle(mouse_x, mouse_y, _x2 - 8, _y + 8, 8))
		{
			if (mouse_check_button_pressed(mb_left))
			{
				trgMenu = false;
			}
			
			hover = true;
		}
		
		else
		{
			if (mouse_check_button_pressed(mb_left))
			{
				var _c = ds_list_create();
				
				collision_point_list(mouse_x, mouse_y, obj_object_parent, false, true, _c, true);
				
				if (ds_list_size(_c) > 0)
				{
					for (var i = 0; i < ds_list_size(_c); i ++)
					{
						with (_c[| i])
						{
							if (accAttr.Main.Condition == "Button Active" && !selected)
							{
								for (var j = 0; j < array_length(other.trgTar); j ++)
								{
									with (other.trgTar[j])
									{
										trigger = [other.id];
									}
								}
								
								other.trgMenu = false;
							}
						}
					}
				}
			}
			
			hover = false;
		}
		
		draw_sprite_ext(spr_arrow, hover, _x2 - 8, _y + 8, -1, 1, 0, $FFFFFF, 1);
		
		if (keyboard_check_pressed(vk_escape))
		{
			trgMenu = false;
		}
	}
	
	if (!altMenu && !saveAs)
	{
		if (open)
		{
			draw_set_color($000000);
			draw_set_alpha(0.4);
			
			draw_rectangle(_x, _y, _x2, _y2, false);
			
			draw_set_color($FFFFFF);
			draw_set_alpha(1.0);
			
			draw_rectangle(_x + 32, _y, _x2 - 32, _y2, false);
			
			draw_set_halign(fa_center);
			
			draw_set_color($000000);
			
			draw_text(global.editX, _y + 8, "Open Level");
			
			draw_set_color($FFFFFF);
			
			var d = working_directory + "levelData.dat",
				o = file_text_open_read(d),
				tempData = [""],
				nameData = "",
				_nn = 0;
			
			while (!file_text_eof(o))
			{
				tempData = file_text_readln(o);
				
				if (tempData != "")
				{
					var json = json_parse(tempData);
					
					nameData[_nn] = json.LevelName;
					_nn ++;
				}
			}
			
			file_text_close(o);
			
			draw_set_halign(fa_left);
			
			levelScroll += (mouse_wheel_up() - mouse_wheel_down()) * 4;
			levelScroll = clamp(levelScroll, -max(0, ceil(array_length(nameData)) * 16), 0);
			
			for (var i = 0; i < array_length(nameData); i ++)
			{
				if (point_in_rectangle(mouse_x, mouse_y, _x + 39, _y + 16 + levelScroll + i * 16, _x + 39 + string_width(nameData[i]), _y + 24 + levelScroll + i * 16) && mouse_y > _y + 16)
				{
					draw_set_color($FFDEAA);
					
					if (mouse_check_button_pressed(mb_left))
					{
						global.go = false;
						
						load_level(nameData[i]);
						
						levelScroll = 0;
						
						open = false;
					}
				}
				
				else
				{
					draw_set_color($000000);
				}
				
				draw_text(_x + 40, _y + 22 + levelScroll + i * 16, nameData[i]);
			}
			
			if (keyboard_check_pressed(vk_escape))
			{
				levelScroll = 0;
				
				open = false;
			}
		}
	}
	
	if (mouse_check_button_released(mb_left))
	{
		global.go = true;
	}
	
	//draw_clear_alpha($FFFFFF, 0);
	
	//surface_reset_target();
}

if (keyboard_check_pressed(vk_f2))
{
	toggle_editor();
}
