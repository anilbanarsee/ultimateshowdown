infinite_mass_punch = class({})
LinkLuaModifier("modifier_infinite_mass_punch", LUA_MODIFIER_MOTION_NONE)

function infinite_mass_punch:OnSpellStart(keys)

	print("infinite_mass_punch");
	
	local range = self:GetLevelSpecialValueFor( "range", self:GetLevel() - 1 )
	caster = self:GetCaster();
	print(caster)
	target = self:GetCursorPosition();
	impact_radius = 200;
	damage_radius = 500;
	damagecoef = 0.01;

	knockbackDistance = 600;
	n = 1;
	
	casterPos = caster:GetAbsOrigin()

	forwardVec = ( target - casterPos ):Normalized()
	iPS = 100;
	local startspeed = 0;
	local endspeed = 40000;
	speed = startspeed;
	
	--local totalDistance =  (target-casterPos): Length2D()
	local totalDistance = range
	--local interval = speed/iPS
	--local speedDiff = endspeed-startspeed;
	
	--local numInts = totalDistance/interval;
	
	speedInc = (((endspeed*endspeed)-(startspeed*startspeed))/(2*totalDistance))/iPS
	--speedInc = (((endspeed*endspeed)-(startspeed*startspeed))/(2*totalDistance))
	print(speedInc)
	

	caster:AddNewModifier(caster, self, "modifier_infinite_mass_punch", { })

	
	self:SetThink("Move", self)

	
	--[[
	local info = 
	{
		Ability = self,
		EffectName = "particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf",
		--EffectName = "particles/units/heroes/hero_stormspirit/stormspirit_ball_lightning.vpcf",
		vSpawnOrigin = caster:GetAbsOrigin(),
		fDistance = (target-casterPos): Length2D(),
		fStartRadius = 100,
		fEndRadius = 100,
		Source = caster,
		bHasFrontalCone = false,
		bReplaceExisting = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO,
		--fExpireTime = GameRules:GetGameTime()+100.0,
		bDeleteOnHit = false,
		vVelocity = (target-caster:GetAbsOrigin()):Normalized()*10,
		vAcceleration = forwardVec*5,
		bProvidesVision = true,
		iVisionRadius = 1000,
		iVisionTeamNumber = caster:GetTeamNumber()
	}
	
	
	projectile = ProjectileManager:CreateLinearProjectile(info)
	--]]
	--[[
	Physics:Unit(caster)
	caster:PreventDI(true)
	caster:SetPhysicsVelocityMax(10000)
	caster:AddPhysicsVelocity(forwardVec*500)
	caster:SetPhysicsAcceleration(forwardVec*10000)
	caster:SetPhysicsFriction(0)
	caster:OnPhysicsFrame(function(unit)
	
		local direction = caster:GetAbsOrigin() - target

		print(direction:Length2D())
		if direction:Length2D()<100 then
			caster:SetPhysicsAcceleration(Vector(0,0,0))
			caster:SetPhysicsVelocity(Vector(0,0,0))
			caster:OnPhysicsFrame(nil)
			caster:PreventDI(false)
		end
		
		--print(unit:GetPhysicsVelocity())
	
	end)
	--]]
	
	
end


function infinite_mass_punch:OnAbilityPhaseStart()
	
	EmitSoundOnLocationWithCaster( self:GetCaster():GetAbsOrigin(), "Hero_Tusk.WalrusPunch.Cast", self:GetCaster() )
	self:GetCaster():StartGestureWithPlaybackRate( ACT_DOTA_ATTACK , 0.5)
    return true
end

function infinite_mass_punch:Move()

	n=n+1
	casterPos = casterPos + forwardVec * (speed/iPS)
	speed = speed+speedInc
	--print(speed)
	FindClearSpaceForUnit( caster, casterPos, false )
	
	local units = FindUnitsInRadius(caster:GetTeamNumber(), casterPos, nil, impact_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false)
	caster:SetForwardVector(forwardVec)
	
	for i,unit in ipairs(units) do
		
		effectPos = unit:GetAbsOrigin()
		self:ImpactEffect()
		self:Impact()
		
		self:StartKnockback(unit)
		
		--print("HIT UNIT")
		return nil
	
	end
	
	if(target-casterPos):Length2D() <= speed/iPS then
		print(speed)
		local lineUnits = FindUnitsInLine(caster:GetTeamNumber(), casterPos, target, nil, impact_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0)
		
		for i,unit in ipairs(lineUnits) do
			
			effectPos = unit:GetAbsOrigin()
			self:StartKnockback(unit)
		
		end
		
		casterPos = target
		FindClearSpaceForUnit( caster, casterPos, false )
		effectPos = casterPos
		self:ImpactEffect()
		self:Impact()
		--print("ENDED")
		return nil
	else
		return 1/iPS
	end
	
end

function infinite_mass_punch:StartKnockback(unit)

	distanceKnockbacked = 0
	targetUnit = unit
	targetPos = unit:GetAbsOrigin()
	knockbackSpeed = speed/4
	knockbackVector = targetPos-casterPos:Normalized()
	unit:SetThink("Knockback", self)
	EmitSoundOnLocationWithCaster( effectPos, "Hero_Tusk.WalrusPunch.Target", self:GetCaster() )
	local damage = {
		victim = unit,
		attacker = caster,
		damage = speed*damagecoef,
		damage_type = DAMAGE_TYPE_MAGICAL
	}
	ApplyDamage(damage)

end

function infinite_mass_punch:Knockback()

	print("Knockback speed : "..knockbackSpeed)
	distanceKnockbacked = distanceKnockbacked+(knockbackSpeed/iPS);
	targetPos = targetPos + (forwardVec*(knockbackSpeed/iPS));
	FindClearSpaceForUnit( targetUnit, targetPos, false )
	knockbackSpeed = knockbackSpeed - knockbackSpeed/10;
	

	if knockbackSpeed<100 then
		return nil
	else 
		return 1/iPS
	end
	
	
end

function infinite_mass_punch:Impact()
	
	
	local units = FindUnitsInRadius(caster:GetTeamNumber(), casterPos, nil, damage_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false)
	caster:RemoveModifierByName("modifier_infinite_mass_punch")
	StopSoundOn("Hero_Tusk.WalrusPunch.Cast", self:GetCaster())
	
	for i,unit in ipairs(units) do
	
			
 
		local damage = {
			victim = unit,
			attacker = caster,
			damage = speed*damagecoef,
			damage_type = DAMAGE_TYPE_MAGICAL
		}
		ApplyDamage(damage)
		
	end	

end

function infinite_mass_punch:ImpactEffect()
		
		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap_cracks.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, effectPos )
		ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 100, 1, 1 ) )
		ParticleManager:ReleaseParticleIndex( nFXIndex )
		
		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, effectPos )
		ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 100, 1, 1 ) )
		ParticleManager:ReleaseParticleIndex( nFXIndex )
		
		EmitSoundOnLocationWithCaster( effectPos, "Hero_Leshrac.Split_Earth", self:GetCaster() )
end