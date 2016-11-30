-- Generated from template

require('timers')
require('ultimateshowdown')

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
end

-- Create the game mode when we activate
function Activate()
	print("HELLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLO")
	GameRules.GameMode = GameMode()
	GameRules.GameMode:InitGameMode()
end

