phase_dash = class({})
LinkLuaModifier("modifier_test", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_speed_force", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phase_dash_charges", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phase_dash", LUA_MODIFIER_MOTION_NONE)

function phase_dash:OnUpgrade()

	
print("PHASE DASH UPGRADED WITH SETUP")
	
	if not setup then
		print("PHASE DASH UPGRADED WITHOUT SETUP")
		charges = 0
		max_charges = 3
		currentCharge = 0
		chargeTime = 30
		caster = self:GetCaster()	
		caster:AddNewModifier(caster, self, "modifier_phase_dash_charges", {duration = 5, charges = 3})

		
		--caster:SetThink("RefreshCharges", self)
	end
	


	setup = true

end

function phase_dash:CastFilterResultLocation(vLocation)


	if caster:FindModifierByName("modifier_phase_dash_charges"):CanRemoveCharge() then
		return UF_SUCCESS
	else
		return UF_FAIL_CUSTOM
		--return UF_SUCCESS
	end

end

function phase_dash:OnSpellStart()

	targetPos = self:GetCursorPosition()
	caster = self:GetCaster()
	caster:FindModifierByName("modifier_phase_dash_charges"):RemoveCharge()
	self:GetCaster():StartGestureWithPlaybackRate( ACT_DOTA_ATTACK , 2)
	--chargeMod:RemoveCharge()
	--self:Move()
	self:StartDashProjectile()
	--self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_speed_force", { duration = 5 })
	
end

function phase_dash:RefreshCharges()

	if charges<max_charges  then
		currentCharge = currentCharge + 1
	end
	
	if currentCharge>=chargeTime then
		currentCharge = 0
		charges = charges + 1
		caster:FindModifierByName("modifier_phase_dash_charges"):SetStackCount(charges)
	end

	return 0.5
end

function phase_dash:StartDashProjectile()
	
	vInc = (targetPos-caster:GetAbsOrigin()):Normalized()*10
	local info = 
	{
		Ability = self,
		EffectName = "particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf",
		--EffectName = "particles/units/heroes/hero_stormspirit/stormspirit_ball_lightning.vpcf",
		vSpawnOrigin = caster:GetAbsOrigin(),
		fDistance = (targetPos-caster:GetAbsOrigin()):Length2D(),
		fStartRadius = 100,
		fEndRadius = 100,
		Source = caster,
		bHasFrontalCone = false,
		bReplaceExisting = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO,
		fExpireTime = GameRules:GetGameTime()+20.0,
		bDeleteOnHit = false,
		vVelocity = (targetPos-caster:GetAbsOrigin()):Normalized()*3000,
		bProvidesVision = true,
		iVisionRadius = 1000,
		iVisionTeamNumber = caster:GetTeamNumber()
	}
	projectile = ProjectileManager:CreateLinearProjectile(info)
	caster:AddNewModifier(caster, self, "modifier_phase_dash", { })
	

end 

function phase_dash:OnProjectileHit(hTarget, vLoc)

	if IsServer() then
		if not hTarget then
			caster:RemoveModifierByName("modifier_phase_dash")
			
			
			return
		end
		local damage = {
				victim = hTarget,
				attacker = caster,
				damage = caster:GetIdealSpeed()*0.5,
				damage_type = DAMAGE_TYPE_MAGICAL
			}
		ApplyDamage(damage)
		caster:AddNewModifier(caster, self, "modifier_speed_force", {duration = 5})
		hTarget:AddNewModifier(caster, self, "modifier_test", {duration = 5})
	end

end

function phase_dash:OnProjectileThink(vLoc)


	FindClearSpaceForUnit(caster, vLoc+vInc, false)

end

function phase_dash:Move()

	local units = FindUnitsInLine(caster:GetTeamNumber(), caster:GetAbsOrigin(), targetPos, nil, 200, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0)
		
	numberToBeAdded = 0 
	
	for i,unit in ipairs(units) do
	
		unit:AddNewModifier(unit, self, "modifier_test", {duration = 5})
		
		numberToBeAdded = numberToBeAdded + 1
		
	end
	
	caster:SetThink("GiveSpeedForce", self)
	
	FindClearSpaceForUnit( caster, targetPos, false )

end

function phase_dash:GiveSpeedForce()
	
	if numberToBeAdded==0 then
		return nil
	end
	
	numberToBeAdded = numberToBeAdded - 1
	
	caster:AddNewModifier(caster, self, "modifier_speed_force", {duration = 5})
	

	return 0.01
	

end