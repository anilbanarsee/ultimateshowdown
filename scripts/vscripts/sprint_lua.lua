sprint_lua = class({})
LinkLuaModifier("modifier_sprint_lua", LUA_MODIFIER_MOTION_NONE)

function sprint_lua:OnSpellStart()
	print("FIRE FIST!");
	
	
	local caster = self:GetCaster();
	
	caster:AddNewModifier(caster, self, "modifier_sprint_lua", { duration = 4}); 
end