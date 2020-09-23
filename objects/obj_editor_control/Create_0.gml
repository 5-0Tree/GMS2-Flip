/// @description Init

depth = -90;

global.edit = true;
global.editX = 0;
global.editY = 0;

//surfGUI = surface_create(global.WIDTH, global.HEIGHT);

angle = 0;

wpID = 0;
wpNum = 0;
wpType = 1;
wpPlace = [];

selObj = -1;
selCat = 0;
  
scroll = [];

global.expanded = 1;

expandDir = -1;
expandPressed = false;

global.hist = [];
global.hNum = 0;

objs = {
	Blocks : [
		obj_wall,
		obj_wall_sp_anti
	], Active : [
		obj_wall_sp_mp,
		obj_waypoint
	], Enemy : [
		obj_wall_sp_c,
		obj_wall_sp_m
	], Player : [
		obj_player,
		obj_goal
	]
};

objNames = variable_struct_get_names(objs);

for (var i = 0; i < array_length(objNames); i ++)
{
	scroll[i] = 0;
}

lname = "New Level";
lchanged = false;

instance_create_layer(0, 0, "Control", obj_camera);
