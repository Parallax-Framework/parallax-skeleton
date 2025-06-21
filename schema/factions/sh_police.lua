FACTION_POLICE = Parallax.Faction:Register({
    Name = "Police",
    Description = "The police are the law enforcement of the city. They are responsible for maintaining order and enforcing the law.",
    Color = Color(20, 50, 150),
    IsDefault = true,

    Image = "gamepadui/hl2/chapter3",

    Models = {
        "models/player/gasmask.mdl",
        "models/player/riot.mdl",
        "models/player/swat.mdl",
        "models/player/urban.mdl"
    }
})