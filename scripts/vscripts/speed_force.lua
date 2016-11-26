speed_force = class({})
LinkLuaModifier("modifier_speed_force", LUA_MODIFIER_MOTION_NONE)

function speed_force:OnToggle()
	
	print("speed force enabled");

	local caster = self:GetCaster();

	

	speed_force_on = self:GetToggleState();
	print(speed_force_on);
	if self:GetToggleState() then
		caster:AddNewModifier(caster, self, "modifier_speed_force", { });
	else
		caster:RemoveModifierByNameAndCaster("modifier_speed_force", caster);
	end
	
end


