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
		data += "{" + 
				string(object_index) +
				", " +
				string(image_angle) +
				", " +
				string(x) +
				", " +
				string(y) +
				", " +
				string(editLayer) +
				", " +
				string(movable) +
				", " +
				string(a_origin) +
				", " +
				string(x_origin) +
				", " +
				string(y_origin) +
				", " +
				string(wpID) +
				", " +
				string(wpNum) +
				", " +
				string(wpType) +
				", " +
				string(moveSpeed) +
				", " +
				string(pl) +
				"}; ";
	}
	
	data += "\n";
	
	file_text_write_string(ap, data);
	
	file_text_close(ap);
}
