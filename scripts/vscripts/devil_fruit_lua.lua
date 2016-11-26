devil_fruit_lua = class({})
LinkLuaModifier("modifier_devil_fruit_lua", LUA_MODIFIER_MOTION_NONE)

function devil_fruit_lua:OnUpgrade()
	print("SUPER SPEED APPLIED!");
	
	
	local caster = self:GetCaster();
	
	caster:AddNewModifier(caster, self, "modifier_devil_fruit_lua", { duration = 200000000000000000000000000}); 
end