/// @description Init

global.edit = false;

global.screenRotSpd = 5;
global.screenAngle = 0;
global.canRotate = false;
global.angleFix = 0;

if (room = rm_init)
{
	room_goto_next();
}
