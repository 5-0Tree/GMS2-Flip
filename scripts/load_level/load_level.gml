/// @description save_level

function load_level(level_name)
{
	var d = working_directory + "levelData.dat",
		o = file_text_open_read(d),
		data = [],
		num = 0;
	
	while (!file_text_eof(o))
	{
		var o_l = file_text_readln(o);
		
		o_l = file_text_readln(o);
		
		if (o_l == "[Level Name]: " + level_name)
		{
			o_l = file_text_readln(o);
			
			while (string_count("[Level Name]: ", o_l) == 0)
			{
				data[num] = o_l;
				
				o_l = file_text_readln(o);
				
				num ++;
			}
			
			break;
		}
	}
	
	file_text_close(o);
	
	for (var i = 0; i < array_length(data); i ++)
	{
		var json = json_parse(data[i]);
		
		with (instance_create_layer(json.X, json.Y, "Objects", json.Object))
		{
			image_angle = json.Angle;
			color = json.Color;
			alpha = json.Alpha;
			group = json.Group;
			editLayer = json.Layer;
			movable = json.Movable;
			a_origin = json.AOrigin;
			x_origin = json.XOrigin;
			y_origin = json.YOrigin;
			wpID = json.WaypointID;
			wpNum = json.WaypointNum;
			wpType = json.WaypointType;
			moveSpeed = json.MoveSpeed;
			pl = json.PointList;
			locked = json.Locked;
			cond = json.Condition;
			trigger = json.Trigger;
		}
	}
}
