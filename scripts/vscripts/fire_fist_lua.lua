fire_fist_lua = class({})
LinkLuaModifier("modifier_fire_fist_lua", LUA_MODIFIER_MOTION_NONE)

function fire_fist_lua:OnSpellStart()
	print("FIRE FIST!");
	
	
	local caster = self:GetCaster();
	
	caster:AddNewModifier(caster, self, "modifier_fire_fist_lua", { duration = 20}); 
end