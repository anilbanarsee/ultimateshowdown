-- Generated from template


require('ultimateshowdown')
require('projectiles')
require('physics')
require('timers')

function Precache( context )
	
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
			
	]]
		PrecacheResource("particle", "particles/units/heroes/hero_magnataur", context)
		PrecacheResource("particle", "particles/units/heroes/hero_abaddon", context)
		PrecacheResource("particle", "particles/magnataur_shockwave_follow.vpcf", context)
		PrecacheResource("particle", "particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf", context)
		PrecacheResource("model", "models/items/keeper_of_the_light/cradle_of_lights_spirit_stag/cradle_of_lights_spirit_stag.vmdl", context)
end

-- Create the game mode when we activate
function Activate()
	print("HELLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLO")
	GameRules.GameMode = GameMode()
	GameRules.GameMode:InitGameMode()
end

