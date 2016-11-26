function ShadowClone( event )
	
	print("SUPER SPEED APPLIED!");
	
	local caster = event.caster
	local player = caster:GetPlayerID()
	local ability = event.ability
	local unit_name = caster:GetUnitName()
	local images_count = ability:GetLevelSpecialValueFor("images_count", ability:GetLevel()-1)
	local duration = ability:GetLevelSpecialValueFor("illusion_duration", ability:GetLevel()-1)
	local outgoingDamage =  ability:GetLevelSpecialValueFor("illusion_outgoing_damage", ability:GetLevel() - 1)
	local incomingDamage = 	ability:GetLevelSpecialValueFor("illusion_incoming_damage", ability:GetLevel() - 1)
	
	local casterOrigin = caster:GetAbsOrigin()
	local casterAngles = caster:GetAngles()
	
	caster:Stop()
	
	if not caster.shadow_clone_illusions then
		caster.shadow_clone_illusions = {}
	end
	
	for k,v in pairs(caster.shadow_clone_illusions) do
		if v and IsValidEntity(v) then
			v:ForceKill(false)
		end
	end
	
	caster.shadow_clone_illusions = {}
	
	local vRandomSpawnPos = {
		Vector(500,0,0),
		Vector(0,500,0),
		Vector(-500,0,0),
		Vector(0, -500,0),
	}
	
	for i=#vRandomSpawnPos, 2, -1 do
		local j = RandomInt(1, i)
		vRandomSpawnPos[i], vRandomSpawnPos[j] = vRandomSpawnPos[j], vRandomSpawnPos[i]
	end
	
	table.insert( vRandomSpawnPos, RandomInt(1,images_count+1), Vector(0,0,0))
	
	FindClearSpaceForUnit(caster, casterOrigin + table.remove(vRandomSpawnPos, 1),true)
	
	for i=1, images_count do
		
		local origin = casterOrigin + table.remove(vRandomSpawnPos, 1)
		local illusion = CreateUnitByName(unit_name, origin, true, caster, nil, caster:GetTeamNumber())
		illusion:SetPlayerID(caster:GetPlayerID())
		illusion:SetControllableByPlayer(player, true)
		
		illusion:SetAngles(casterAngles.x, casterAngles.y, casterAngles.z)
		
		local casterLevel=caster:GetLevel()
		for i=1, casterLevel-1 do
			illusion:HeroLevelUp(false)
		end
		
		illusion:SetAbilityPoints(0)
		for abilitySlot=0, 15 do
			local ability = caster:GetAbilityByIndex(abilitySlot)
			if ability ~= nil then
				local abilityLevel=ability:GetLevel()
				local abilityName = ability:GetAbilityName()
				local illusionAbility = illusion:FindAbilityByName(abilityName)
				illusionAbility:SetLevel(abilityLevel)
			end
		end
		
		for itemSlot=0,5 do
			local item = caster:GetItemInSlot(itemSlot)
			if item ~= nil then
				local itemName = item:GetName()
				local new Item = CreateItem(itemName, illusion, illusion)
				illusion:AddItem(newItem)
			end
			
		end
		
		illusion:AddNewModifier(caster, ability, "modifier_illusion", {duration = duration, outgoing_damage = outgoingDamage, incoming_damage = incomingDamage })
		illusion:MakeIllusion()
		illusion:SetHealth(caster:GetHealth())
		table.insert(caster.shadow_clone_illusions, illusion)
		
	end
end
	