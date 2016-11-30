modifier_speed_force_hidden = class({})
LinkLuaModifier("modifier_speed_force", LUA_MODIFIER_MOTION_NONE)

function modifier_speed_force_hidden:DeclareFunctions()
	
		local funcs_array = {
			MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
			MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
			MODIFIER_PROPERTY_MANA_BONUS
			}
		
		return funcs_array
end


function modifier_speed_force_hidden:OnCreated(kv)

		

end

function modifier_speed_force_hidden:IsHidden() return true end

function modifier_speed_force_hidden:RemoveOnDeath() return false end

function modifier_speed_force_hidden:IsPurgable() return false end

function modifier_speed_force_hidden:IsPurgableException() return false end

function modifier_speed_force_hidden:GetModifierBaseAttack_BonusDamage(params)

	local modTarget = self:GetParent()

	
	
	

	return modTarget:GetIdealSpeed()*0.1
	

end

function modifier_speed_force_hidden:GetModifierManaBonus(params)
	
	print("Setting mana to :" .. 100-(self:GetParent():GetMana()))
	
	if not last_mana_amp then
		last_mana_amp = 100-(self:GetParent():GetMaxMana())
	else
		last_mana_amp = 100-(self:GetParent():GetMaxMana()-last_mana_amp)
	end
		

	return last_mana_amp


end

function modifier_speed_force_hidden:GetModifierConstantManaRegen(params)

	return 20-(self:GetParent():GetManaRegen())

end
