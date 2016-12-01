modifier_phase_dash_charges = class({})


function modifier_phase_dash_charges:OnCreated(kv)


	if IsServer() then
		charges = kv.charges or 0
		max_charges = 3
		if charges >= max_charges then
			charges = max_charges
			self:SetDuration(-1, true)
		end
		print(charges)
		self:SetStackCount(charges)
	
	
	end


end

function modifier_phase_dash_charges:AddStack()



end

function modifier_phase_dash_charges:CanRemoveCharge()

	if charges==0 then
		return false
	end
	
	return true

end
function modifier_phase_dash_charges:RemoveCharge()
	
	if charges==0 then
		return false
	end
	
	if charges == max_charges then
		self:SetDuration(10, true)
	end
	charges = charges-1

	self:SetStackCount(charges)
		return true
	
		
end

function modifier_phase_dash_charges:OnDestroy()

	if IsServer() then
		
		if charges >= max_charges-1 then
			self:GetParent():AddNewModifier(self:GetParent(), self, "modifier_phase_dash_charges", {charges = charges+1})
		else
			self:GetParent():AddNewModifier(self:GetParent(), self, "modifier_phase_dash_charges", {charges = charges+1, duration = 10})
		end
	end

end
