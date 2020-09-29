/// @description Init

depth = -90;

global.edit = true;
global.editX = 0;
global.editY = 0;
global.Layer = 0;
global.maxLayer = 99;

//surfGUI = surface_create(global.WIDTH, global.HEIGHT);

angle = 0;

wpN = 0;
wpID = 0;
wpNum = 0;
wpType = 1;
wpPlace = [];

selObj = -1;
selCat = 0;

scroll = [];

global.go = true;

global.expanded = 1;

expandDir = -1;
expandPressed = false;

clickingButton = false;

global.hist = [];
global.hNum = 0;

objs = {
	Blocks : [
		obj_wall_1,
		obj_wall_2,
		obj_wall_3,
		obj_wall_4
	], Active : [
		obj_box_1,
		obj_waypoint,
		obj_wall_sp_mp_1,
		obj_wall_sp_anti
	], Enemy : [
		obj_wall_sp_c,
		obj_wall_sp_m,
		obj_enemy_c,
		obj_enemy_m,
		obj_spikes
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
