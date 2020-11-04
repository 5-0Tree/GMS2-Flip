/// @description Init

event_inherited();

depth = 10;

startCon = "Player Over";
atEnd = false;

wp = noone;
wpPoint = 0;

init = false;

AccAttr = {
	Main : {
		Color : image_blend,
		Angle : image_angle,
		Alpha : image_alpha,
		Group : group
	},
	Active : {
		Locked : locked,
		Condition : startCon,
		Speed : undefined,
		Trigger : undefined
	}
};
