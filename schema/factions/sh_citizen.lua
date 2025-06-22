FACTION_CITIZEN = Parallax.Faction:Instance()
FACTION_CITIZEN:SetName("Citizen")
FACTION_CITIZEN:SetDescription("An ordinary citizen living life while wearing ridiculous clothing.")
FACTION_CITIZEN:SetColor(Color(20, 150, 20))
FACTION_CITIZEN:MakeDefault()

FACTION_CITIZEN.Image = Parallax.Util:GetMaterial("gamepadui/hl2/chapter1")

FACTION_CITIZEN = FACTION_CITIZEN:Register()