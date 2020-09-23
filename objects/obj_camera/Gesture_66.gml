/// @description Begin Pan

if (keyboard_check(vk_space) && global.edit)
{
	if (event_data[? "posX"] > 56 * global.expanded + global.editX - global.WIDTH / 2)
	{	
		dragStart = true;
		
		dragX = x * 8 + event_data[? "rawposX"];
		dragY = y * 8 + event_data[? "rawposY"];
	}
}
