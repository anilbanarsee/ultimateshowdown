modifier_infinite_mass_punch = class({})



function modifier_infinite_mass_punch:OnCreated(kv)

	if IsServer() then
	local caster = self:GetParent()
	local particleName = "particles/magnataur_shockwave_follow.vpcf"
	particle = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 3, Vector(0,0,0))
	Timers:CreateTimer({
	    endTime = 3, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
    callback = function()
      print("Timer done")
    end
  })
	self:GetParent():AddNoDraw()
  end
	self:GetParent():AddNoDraw()
	--caster:SetModel("models/items/keeper_of_the_light/cradle_of_lights_spirit_stag/cradle_of_lights_spirit_stag.vmdl")
end

function modifier_infinite_mass_punch:OnDestroy()

	local part = particle
	if IsServer() then
	--ParticleManager:DestroyParticle(particle, false)
	Timers:CreateTimer({
    endTime = 0.1, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
    callback = function()
		ParticleManager:DestroyParticle(part, false)
		print("Timer done2")
    end
  })
  end
	self:GetParent():RemoveNoDraw()

end