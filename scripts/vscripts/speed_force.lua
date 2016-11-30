speed_force = class({})
LinkLuaModifier("modifier_speed_force_hidden", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_speed_force", LUA_MODIFIER_MOTION_NONE)

function speed_force:OnUpgrade()
	caster = self:GetCaster()
	caster:AddNewModifier(caster, self, "modifier_speed_force_hidden", { }); 
end



