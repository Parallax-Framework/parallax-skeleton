local ITEM = ax.item:Instance()

ITEM:SetName("Pistol")
ITEM:SetDescription("A standard sidearm, effective at close to medium range.")
ITEM:SetCategory("Weapons")
ITEM:SetModel(Model("models/weapons/w_pistol.mdl"))

ITEM:SetWeight(1.5)

ITEM:SetWeaponClass("weapon_pistol")

ITEM:Register()