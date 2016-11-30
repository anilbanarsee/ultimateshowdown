electrokinesis = class({})

function electrokinesis:OnSpellStart()

	
	local stacks = 0
	local caster = self:GetCaster()
	local speedforcemod = caster:FindModifierByName("modifier_speed_force")
	local aoe = 500
	local stackCoef = 100;
	local casterPos = caster:GetAbsOrigin()
	
	
	if speedforcemod then
		stacks = speedforcemod:GetStackCount()
		caster:RemoveModifierByName("modifier_speed_force")
	end
	
	
	
	local units = FindUnitsInRadius(caster:GetTeamNumber(), casterPos, nil, aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false)
	
	local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap_cracks.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, casterPos )
		ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 1000, 1, 1 ) )
		ParticleManager:ReleaseParticleIndex( nFXIndex )
		
		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, casterPos )
		ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 1000, 1, 1 ) )
		ParticleManager:ReleaseParticleIndex( nFXIndex )
	
	for i,unit in ipairs(units) do
		local damage = {
			victim = unit,
			attacker = caster,
			damage = stacks*stackCoef,
			damage_type = DAMAGE_TYPE_MAGICAL
		}
		ApplyDamage(damage)
	end

end