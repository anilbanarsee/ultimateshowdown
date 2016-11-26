modifier_speed_force = class({})

function modifier_speed_force:DeclareFunctions()
	
		local funcs_array = {
			MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE ,
			MODIFIER_PROPERTY_MOVESPEED_MAX,
			MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
			}
		
		return funcs_array
end

function modifier_speed_force:GetModifierMoveSpeed_Absolute(params)
	return 5000;
end

function modifier_speed_force:GetModifierMoveSpeed_Max(params)
	return 5000;
end

function modifier_speed_force:GetModifierAttackSpeedBonus_Constant(params)
	return 1000;
end