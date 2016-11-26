invis_aura_lua = class({})
LinkLuaModifier("modifier_super_strength_lua", LUA_MODIFIER_MOTION_NONE)

function invis_aura_lua:GetAuraRadius()
	return 600;
end