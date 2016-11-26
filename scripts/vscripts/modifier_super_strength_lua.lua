modifier_super_strength_lua = class({})

function modifier_super_strength_lua:DeclareFunctions()
	local funcs_array = {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_PROPERTY_MOVESPEED_MAX,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE
	}
	
	return funcs_array
end

function modifier_super_strength_lua:GetModifierMoveSpeed_Absolute(params)
	return 1000;
end

function modifier_super_strength_lua:GetModifierMoveSpeed_Max(params)
	return 1000;
end

function modifier_super_strength_lua:GetModifierBaseAttack_BonusDamage(params)
	return 1000;
end