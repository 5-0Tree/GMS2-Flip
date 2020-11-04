/// @description Init

event_inherited();

moveSpeed = 4;

AccAttr = {
	Main : {
		Color : undefined,
		Angle : undefined,
		Alpha : undefined,
		Group : group,
		Layer : editLayer
	},
	Active : {
		Locked : undefined,
		Condition : undefined,
		Speed : moveSpeed,
		Trigger : undefined
	}
};
