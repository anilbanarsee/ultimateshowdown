modifier_devil_fruit_lua = class({})

function modifier_devil_fruit_lua:DeclareFunctions()
	local funcs_array = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	}
	
	return funcs_array
end

function modifier_devil_fruit_lua:GetModifierBonusStats_Strength(params)
	return 50;
end