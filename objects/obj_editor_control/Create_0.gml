/// @description Init

depth = -90;

global.edit = true;
global.editX = 0;
global.editY = 0;
global.Layer = 0;
global.maxLayer = 99;

//surfGUI = surface_create(global.WIDTH, global.HEIGHT);

saveAs = false;
open = false;

angle = 0;

wpID = 0;
wpNum = 0;
wpType = 1;
wpPlace = [];

selObj = -1;
selCat = 0;

scroll = [];
levelScroll = 0;

global.go = true;

global.expanded = 1;

expandDir = -1;
expandPressed = false;

clickingButton = false;

altMenu = false;
colMenu = false;
conMenu = false;
trgMenu = false;

selCol = $FFFFFF;
colChg = false;

conTar = [noone];
trgTar = [noone];

selCon = "";
conChg = false;

mainConds = [
	"Player Over",
	"Active Over",
	"Enemy Over",
	"Button Active"
];

selectX = 0;
selectY = 0;

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
		obj_button,
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

altAttr = {
	Main : {
		Color : undefined,
		Angle : undefined,
		Alpha : undefined,
		Group : undefined,
		Layer : undefined,
		Locked : undefined,
		Condition : undefined,
		Speed : undefined,
		Trigger : undefined
	}
};

objNames = variable_struct_get_names(objs);

for (var i = 0; i < array_length(objNames) + 1; i ++)
{
	scroll[i] = 0;
}

global.lname = "New Level";

lchanged = false;

instance_create_layer(0, 0, "Control", obj_camera);
