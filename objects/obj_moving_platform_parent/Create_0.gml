/// @description Init

event_inherited();

depth = 10;

startCon = "Player Over";
atEnd = false;

wp = noone;
wpPoint = 0;

init = false;

accAttr = {
	Main : {
		Color : color,
		Angle : image_angle,
		Alpha : alpha,
		Group : group,
		Layer : editLayer,
		Locked : locked,
		Condition : startCon,
		Speed : undefined,
		Trigger : undefined
	}
};
