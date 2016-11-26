modifier_invis_aura_lua = class({})


function modifier_invisible_etd:CheckState() 
  local state = {
      [MODIFIER_STATE_INVISIBLE] = true,
  }

  return state
end

function modifier_invisible_etd:IsHidden()
    return true
end