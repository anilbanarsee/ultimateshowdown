infinite_mass_punch = class({})
LinkLuaModifier("modifier_infinite_mass_punch", LUA_MODIFIER_MOTION_NONE)

function infinite_mass_punch:OnSpellStart()

	print("infinite_mass_punch");
	
	local range = self:GetLevelSpecialValueFor( "range", self:GetLevel() - 1 )
	caster = self:GetCaster();
	target = self:GetCursorPosition();
	impact_radius = 200;
	damage_radius = 500;
	damagecoef = 0.05;

	knockbackDistance = 600;
	n = 1;
	
	casterPos = caster:GetAbsOrigin()
	EmitSoundOnLocationWithCaster( casterPos, "Hero_Windranger.Windrun", self:GetCaster() )
	forwardVec = ( target - casterPos ):Normalized()
	iPS = 50;
	local startspeed = 500;
	local endspeed = 10000;
	speed = startspeed;
	
	--local totalDistance =  (target-casterPos): Length2D()
	local totalDistance = range
	--local interval = speed/iPS
	--local speedDiff = endspeed-startspeed;
	
	--local numInts = totalDistance/interval;
	
	speedInc = (((endspeed*endspeed)-(startspeed*startspeed))/(2*totalDistance))/iPS
	print(speedInc)
	
	caster:SetThink("Move", self)

	
end


function infinite_mass_punch:Move()
	n=n+1
	casterPos = casterPos + forwardVec * (speed/iPS)
	speed = speed+speedInc
	FindClearSpaceForUnit( caster, casterPos, false )
	
	local units = FindUnitsInRadius(caster:GetTeamNumber(), casterPos, nil, impact_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false)
	
	
	for i,unit in ipairs(units) do
		
		effectPos = unit:GetAbsOrigin()
		self:ImpactEffect()
		self:Impact()
		distanceKnockbacked = 0
		targetUnit = unit
		targetPos = unit:GetAbsOrigin()
		knockbackSpeed = speed;
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
		
		return nil
	
	end
	
	if(target-casterPos):Length2D() <= speed/iPS then
		print(speed)
		effectPos = casterPos
		self:ImpactEffect()
		self:Impact()
		return nil
	else
		return 1/iPS
	end
	
end

function infinite_mass_punch:Knockback()

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