local FACTION = ax.faction:Instance()
FACTION:SetName("Citizen")
FACTION:SetDescription("An ordinary citizen living life while wearing ridiculous clothing.")
FACTION:SetColor(Color(20, 150, 20))
FACTION:MakeDefault()

FACTION.Image = ax.util:GetMaterial("gamepadui/hl2/chapter1")

FACTION_CITIZEN = FACTION:Register()