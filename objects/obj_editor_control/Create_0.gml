/// @description Init

depth = -90;

global.edit = true;
global.editX = 0;
global.editY = 0;

//surfGUI = surface_create(global.WIDTH, global.HEIGHT);

xx = 0;
yy = 0;

selObj = -1;
selCat = 0;

global.expanded = 1;
expandDir = -1;

objs = {
	blocks : [
		obj_wall,
		obj_wall_sp_anti,
		obj_wall_sp_mp,
		obj_waypoint
	], interactive : [
		obj_wall_sp_mp,
		obj_waypoint
	], hazards : [
		obj_wall_sp_c,
		obj_wall_sp_m
	]
};

objNames = variable_struct_get_names(objs);

instance_create_layer(0, 0, "Control", obj_camera);
