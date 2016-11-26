modifier_fire_fist_lua = class({})

function modifier_fire_fist_lua:DeclareFunctions()
	local funcs_array = {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_PROPERTY_MOVESPEED_MAX,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	}
	
	return funcs_array
end

function modifier_fire_fist_lua:GetModifierMoveSpeed_Absolute(params)
	return 1000;
end

function modifier_fire_fist_lua:GetModifierMoveSpeed_Max(params)
	return 1000;
end

function modifier_fire_fist_lua:GetModifierBonusStats_Strength(params)
	return 40;
end