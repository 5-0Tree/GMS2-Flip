/// @description save_level

function save_level(level_name)
{
	var d = working_directory + "levelData.dat",
		o = file_text_open_read(d),
		num = 0,
		data = "",
		l_n = level_name,
		t_n = l_n,
		n = 1;
	
	while (!file_text_eof(o))
	{
		var o_s = file_text_readln(o);
		
		num = real(string_digits(o_s)) + 1;
		
		o_s = file_text_readln(o);
		
		if (string_count(level_name, o_s) > 0)
		{
			t_n = level_name + " (" + string(n) + ")";
			
			l_n = t_n;
			n ++;
		}
		
		file_text_readln(o);
	}
	
	file_text_close(o);
	
	var ap = file_text_open_append(d);
	
	data = "[Level ID]: " + string(num) + "\n[Level Name]: " + l_n + "\n[Object Data]: ";
	
	with (obj_object_parent)
	{
		data += "{\"Object\" : " +
				string(object_index) +
				", \"Angle\" : " +
				string(image_angle) +
				", \"X\" : " +
				string(x) +
				", \"Y\" : " +
				string(y) +
				", \"Color\" : " +
				string(color) +
				", \"Alpha\" : " +
				string(alpha) +
				", \"Group\" : " +
				string(group) +
				", \"Layer\" : " +
				string(editLayer) +
				", \"Movable\" : " +
				string(movable) +
				", \"AOrigin\" : " +
				string(a_origin) +
				", \"XOrigin\" : " +
				string(x_origin) +
				", \"YOrigin\" : " +
				string(y_origin) +
				", \"WaypointID\" : " +
				string(wpID) +
				", \"WaypointNum\" : " +
				string(wpNum) +
				", \"WaypointType\" : " +
				string(wpType) +
				", \"MoveSpeed\" : " +
				string(moveSpeed) +
				", \"PointList\" : " +
				string(pl) +
				", \"Locked\" : " +
				string(locked) +
				", \"Condition\" : " +
				string(cond) +
				", \"Trigger\" : " +
				string(trigger) +
				"}; ";
	}
	
	data += "\n";
	
	file_text_write_string(ap, data);
	
	file_text_close(ap);
}
