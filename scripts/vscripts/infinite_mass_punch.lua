infinite_mass_punch = class({})
LinkLuaModifier("modifier_infinite_mass_punch", LUA_MODIFIER_MOTION_NONE)

function infinite_mass_punch:OnSpellStart()

	print("infinite_mass_punch");
	
	caster = self:GetCaster();
	target = self:GetCursorPosition();
	
	n = 1;
	print(target);
	casterPos = caster:GetAbsOrigin()
	forwardVec = ( target - casterPos ):Normalized()
	iPS = 50;
	local startspeed = 500;
	local endspeed = 10000;
	speed = startspeed;
	
	local totalDistance =  (target-casterPos): Length2D()
	local interval = speed/iPS
	local speedDiff = endspeed-startspeed;
	
	local numInts = totalDistance/interval;
	
	speedInc = speedDiff/numInts
	
	
	caster:SetThink("Move", self)

	
end


function infinite_mass_punch:Move()
	
	casterPos = casterPos + forwardVec * (speed/iPS)
	speed = speed+speedInc
	FindClearSpaceForUnit( caster, casterPos, false )
	
	if(target-casterPos):Length2D() <= speed/iPS then
	
		return nil
	else
		return 1/iPS
	end
	
end