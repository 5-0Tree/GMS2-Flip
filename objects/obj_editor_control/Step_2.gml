/// @description Editor Controls

if (global.edit)
{
	if (!altMenu)
	{
		if (keyboard_check(vk_alt))
		{
			if (keyboard_check_pressed(ord("D")))
			{
				with (obj_object_parent)
				{
					selected = false;
				}
			}
		}
		
		if (keyboard_check_pressed(ord("Q")))
		{
			angle += 90;
		}
		
		if (keyboard_check_pressed(ord("E")))
		{
			angle -= 90;
		}
		
		if (keyboard_check(vk_control))
		{
			if (keyboard_check_pressed(ord("S")))
			{
				//Save as
				if (keyboard_check(vk_shift))
				{
					
				}
				
				//Save
				else
				{
					save_level(lname);
				}
				
				lchanged = false;
			}
			
			if (keyboard_check_pressed(ord("Z")) && array_length(wpPlace) == 0)
			{
				with (obj_object_parent)
				{
					selected = false;
				}
				
				//Redo
				if (keyboard_check(vk_shift))
				{
					if (global.hNum < array_length(global.hist))
					{
						if (global.hist[global.hNum][0] == "Add")
						{
							for (var i = 0; i < array_length(global.hist[global.hNum][1]); i ++)
							{
								instance_activate_object(global.hist[global.hNum][1][i]);
							}
							
							global.hNum ++;
						}
						
						else if (global.hist[global.hNum][0] == "Delete")
						{
							for (var i = 0; i < array_length(global.hist[global.hNum][1]); i ++)
							{
								instance_deactivate_object(global.hist[global.hNum][1][i]);
							}
							
							global.hNum ++;
						}
					}
				}
				
				//Undo
				else
				{
					if (global.hNum > 0)
					{
						if (global.hist[global.hNum - 1][0] == "Add")
						{
							global.hNum --;
							
							for (var i = 0; i < array_length(global.hist[global.hNum][1]); i ++)
							{
								instance_deactivate_object(global.hist[global.hNum][1][i]);
							}
						}
						
						else if (global.hist[global.hNum - 1][0] == "Delete")
						{
							global.hNum --;
							
							for (var i = 0; i < array_length(global.hist[global.hNum][1]); i ++)
							{
								instance_activate_object(global.hist[global.hNum][1][i]);
							}
						}
					}
				}
			}
		}
	}
}
