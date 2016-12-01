modifier_test = class({})

function modifier_test:DeclareFunctions()
	local funcs_array = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, 
		MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE
	}
	
	return funcs_array
end

function modifier_test:OnCreated(kv)

	iPS = 2
	duration = self:GetDuration()
	speedLossPS = 10
	turnLossPS = 10
	currentTurnRateLoss = 0;
	currentSpeedLoss = 0;
	self:StartIntervalThink(1/iPS)
end

function modifier_test:OnIntervalThink()

	currentSpeedLoss = currentSpeedLoss-speedLossPS
	currentTurnRateLoss = currentTurnRateLoss - turnLossPS


end

function modifier_test:GetModifierMoveSpeedBonus_Percentage()
	
	return currentSpeedLoss

end

function modifier_test:GetModifierTurnRate_Percentage()

	return currentTurnRateLoss
	
end