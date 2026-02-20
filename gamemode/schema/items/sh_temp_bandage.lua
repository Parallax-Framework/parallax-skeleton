--[[
    Parallax Framework
    Copyright (c) 2025-2026 Parallax Framework Contributors

    This file is part of the Parallax Framework and is licensed under the MIT License.
    You may use, copy, modify, merge, publish, distribute, and sublicense this file
    under the terms of the LICENSE file included with this project.

    Attribution is required. If you use or modify this file, you must retain this notice.
]]

ITEM.name = "Temporary Bandage"
ITEM.description = "A basic placeholder medical item for action menu testing."
ITEM.model = Model("models/props_lab/jar01a.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Temporary"
ITEM.weight = 0.1

ITEM:AddAction("apply", {
    name = "Apply",
    icon = "parallax/icons/check-circle.png",
    OnRun = function(action, item, client)
        if ( !ax.util:IsValidPlayer(client) ) then return false end

        local nextHealth = math.min(client:Health() + 12, client:GetMaxHealth())
        client:SetHealth(nextHealth)
        client:EmitSound("npc/barnacle/barnacle_crunch2.wav", 60, math.random(95, 110))

        return true
    end
})
