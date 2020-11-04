/// @description Init

event_inherited();

locked = false;

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
		Condition : undefined,
		Speed : undefined,
		Trigger : undefined
	}
};
