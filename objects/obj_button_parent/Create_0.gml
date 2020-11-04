/// @description Init

event_inherited();

image_speed = 0;

active = false;

locked = false;
cond = "Player Over";
trigger = noone;

accAttr = {
	Main : {
		Color : image_blend,
		Angle : image_angle,
		Alpha : image_alpha,
		Group : group,
		Layer : editLayer
	},
	Active : {
		Locked : locked,
		Condition : cond,
		Speed : undefined,
		Trigger : trigger
	}
};
