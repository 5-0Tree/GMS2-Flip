/// @description Init

event_inherited();

image_speed = 0;

active = false;

locked = false;
cond = "Player Over";
trigger = [noone];

accAttr = {
	Main : {
		Color : color,
		Angle : image_angle,
		Alpha : alpha,
		Group : group,
		Layer : editLayer,
		Locked : locked,
		Condition : cond,
		Speed : undefined,
		Trigger : trigger
	}
};
