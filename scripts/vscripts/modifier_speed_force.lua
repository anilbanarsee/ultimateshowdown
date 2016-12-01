modifier_speed_force = class({})

function modifier_speed_force:DeclareFunctions()
	
		local funcs_array = {
			MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
			MODIFIER_PROPERTY_MOVESPEED_MAX
			
			}
		
		return funcs_array
end

function modifier_speed_force:IsHidden() return false end

function modifier_speed_force:RemoveOnDeath() return true end

function modifier_speed_force:IsPurgable() return true end

function modifier_speed_force:IsPurgableException() return true end

function modifier_speed_force:GetTexture()
	
	return "magnataur_shockwave"


end

function modifier_speed_force:OnCreated(kv)

	stacks = 1
	self:SetStackCount(stacks)
	target = self:GetParent()
	--print("Creating abaddon sheild thing")
--target.ShieldParticle = ParticleManager:CreateParticle("particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)

--ParticleManager:SetParticleControl(target.ShieldParticle, 1, Vector(100,100,0))
--ParticleManager:SetParticleControl(target.ShieldParticle, 2, Vector(shield_size,0,shield_size))
--ParticleManager:SetParticleControl(target.ShieldParticle, 4, Vector(shield_size,0,shield_size))
--ParticleManager:SetParticleControl(target.ShieldParticle, 5, Vector(shield_size,0,0))

--ParticleManager:SetParticleControlEnt(target.ShieldParticle, 1, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)

end

function modifier_speed_force:OnRefresh(kv)
	
	stacks = stacks+1
	self:SetStackCount(stacks)
	
	
end



function modifier_speed_force:GetModifierMoveSpeed_Max(params)

	return 2000;
end

function modifier_speed_force:GetModifierMoveSpeedBonus_Constant(params)

	
	local stacks = self:GetStackCount()

	return 100*(stacks)
	

end