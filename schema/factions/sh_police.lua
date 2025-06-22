local FACTION = Parallax.Faction:Instance()
FACTION:SetName("Police")
FACTION:SetDescription("The police are the law enforcement of the city. They are responsible for maintaining order and enforcing the law.")
FACTION:SetColor(Color(20, 50, 150))
FACTION:MakeDefault()

FACTION:SetModels({
    "models/player/gasmask.mdl",
    "models/player/riot.mdl",
    "models/player/swat.mdl",
    "models/player/urban.mdl"
})

FACTION.Image = Parallax.Util:GetMaterial("gamepadui/hl2/chapter3")

FACTION_POLICE = FACTION:Register()