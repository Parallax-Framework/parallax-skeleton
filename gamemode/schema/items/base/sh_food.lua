--[[
    Parallax Framework
    Copyright (c) 2025-2026 Parallax Framework Contributors

    This file is part of the Parallax Framework and is licensed under the MIT License.
    You may use, copy, modify, merge, publish, distribute, and sublicense this file
    under the terms of the LICENSE file included with this project.

    Attribution is required. If you use or modify this file, you must retain this notice.
]]

ITEM.name = "Food Base"
ITEM.description = "Base template for temporary consumable example items."
ITEM.model = Model("models/props_junk/garbage_takeoutcarton001a.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Food"
ITEM.health = 5
ITEM.isDrink = false
ITEM.weight = 0.1

ITEM:AddAction("consume", {
    name = "Consume",
    icon = "parallax/icons/check-circle.png",
    OnRun = function(action, client, item)
        if ( !ax.util:IsValidPlayer(client) ) then return false end

        local health = math.max(tonumber(item.health) or 0, 0)
        if ( health > 0 ) then
            client:SetHealth(math.min(client:Health() + health, client:GetMaxHealth()))
        end

        if ( item.isDrink ) then
            client:EmitSound("npc/barnacle/barnacle_gulp1.wav", 65, math.random(95, 110))
        else
            client:EmitSound("npc/barnacle/barnacle_gulp2.wav", 65, math.random(95, 110))
        end

        return true
    end
})
