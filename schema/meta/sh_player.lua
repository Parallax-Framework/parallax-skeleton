local PLAYER = FindMetaTable("Player")

function PLAYER:IsCitizen()
    return self:Team() == FACTION_CITIZEN
end

function PLAYER:IsPolice()
    return self:Team() == FACTION_POLICE
end