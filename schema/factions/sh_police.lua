FACTION_POLICE = Parallax.Faction:Instance()
FACTION_POLICE:SetName("Police")
FACTION_POLICE:SetDescription("The police are the law enforcement of the city. They are responsible for maintaining order and enforcing the law.")
FACTION_POLICE:SetColor(Color(20, 50, 150))
FACTION_POLICE:MakeDefault()

FACTION_POLICE:SetModels({
    "models/player/gasmask.mdl",
    "models/player/riot.mdl",
    "models/player/swat.mdl",
    "models/player/urban.mdl"
})

FACTION_POLICE.Image = Parallax.Util:GetMaterial("gamepadui/hl2/chapter3")

FACTION_POLICE = FACTION_POLICE:Register()