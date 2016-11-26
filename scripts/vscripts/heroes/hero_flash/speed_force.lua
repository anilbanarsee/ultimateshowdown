speed_force = class({})
LinkLuaModifier("modifier_speed_force", LUA_MODIFIER_MOTION_NONE)

function speed_force:OnToggle()
	
	print("speed force enabled");

	local caster = self:GetCaster();
	local ability = self:GetAbility();
	
	
	local n = 5;
	
	if not speed_force_on then
		n = 6;
	end
	
	print(n);
	
	caster:AddNewModifier(caster, self, "modifier_speed_force", { });
	
end


