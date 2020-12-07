/// @description Begin Pan

if (keyboard_check(vk_space) && global.edit)
{
	if (instance_exists(obj_editor_control))
	{
		if (!obj_editor_control.altMenu || obj_editor_control.trgMenu)
		{
			if (event_data[? "posX"] > 56 * global.expanded + global.editX - global.WIDTH / 2)
			{	
				dragStart = true;
				
				dragX = x * 8 + event_data[? "rawposX"];
				dragY = y * 8 + event_data[? "rawposY"];
			}
		}
	}
}
