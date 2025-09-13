local MODULE = MODULE

MODULE.Name = "Curvy Demo"
MODULE.Description = "A demonstration of a curvy HUD style."
MODULE.Author = "Riggs"

CreateClientConVar("ax_demo_curvy_hud", "1", true, false, "Enable the Curvy HUD demo.")

local CurvyHUDDemo = {}

local squadMembers = {
    "GAMMA-1 (*)", "RANGER-1 (N)", "ECHO-1 (RC)", "ECHO-2", "ECHO-3"
}

local headingLerp = 0
local directionLabels = {
    [0] = "N", [45] = "NE", [90] = "E", [135] = "SE",
    [180] = "S", [225] = "SW", [270] = "W", [315] = "NW"
}

local function AngleLerp(frac, a, b)
    -- Handles circular wraparound for degrees
    local diff = (b - a + 540) % 360 - 180
    return (a + diff * frac) % 360
end

function CurvyHUDDemo:DrawGeneralInfo(width, height, client)
    local x, y = width - ScreenScale(16), ScreenScaleH(16)

    -- Header
    local header = ":: SYSTEM STATUS ::"
    local icon = ax.curvy:LoadMaterial("icon16/shield.png")
    local iconSize = ScreenScaleH(10)

    ax.curvy:DrawIcon(icon, x - iconSize - 4, y + iconSize * 0.5, iconSize,
        Color(255, 200, 0), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

    draw.SimpleText(header, "ax.large.bold", x, y, Color(255, 200, 0),
        TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
    y = y + draw.GetFontHeight("ax.large.bold")

    -- Stability display
    local stability = math.Clamp(72, 0, 100)
    local stabilityColor = Color(255, 255 - stability * 2.55, 255 - stability * 2.55)
    local stabilityText = math.Round(stability) .. "%"

    local boxW, boxH = ScreenScale(48), draw.GetFontHeight("ax.regular") * 3

    -- Background
    surface.SetDrawColor(30, 70, 80, 150)
    surface.DrawRect(x - boxW, y + 2, boxW, boxH - 4)

    -- Border
    surface.SetDrawColor(200, 200, 200, 200)
    surface.DrawRect(x - boxW, y, 2, boxH)
    surface.DrawRect(x - 2, y, 2, boxH)

    -- Text
    draw.SimpleText(stabilityText, "ax.large.bold", x - boxW / 2, y + 8,
        stabilityColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    draw.SimpleText("Stability", "ax.regular", x - boxW / 2, y + boxH - 8,
        stabilityColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)

    -- Area info
    local clockIcon = ax.curvy:LoadMaterial("icon16/clock.png")
    local areaName = string.upper(game.GetMap() or "UNKNOWN AREA")
    local timeStr = "(" .. os.date("%H:%M") .. ")"
    local codeStr = "CODE: GREEN"

    local lineY = y + boxH + 2
    ax.curvy:DrawIcon(clockIcon, x - iconSize - 4, lineY + iconSize * 0.6,
        iconSize, Color(200, 200, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

    draw.SimpleText(areaName .. " " .. timeStr, "ax.regular", x, lineY,
        Color(200, 200, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
    draw.SimpleText(codeStr, "ax.regular", x,
        lineY + draw.GetFontHeight("ax.regular"),
        Color(200, 255, 200), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
end

function CurvyHUDDemo:DrawCompass(width, height, client)
    local yaw = EyeAngles().yaw % 360
    headingLerp = AngleLerp(FrameTime() * 8, headingLerp, yaw)

    local pixelsPerDegree = ScreenScale(2)
    local centerX = width / 2
    local centerY = ScreenScaleH(16)
    local fadeRange = width / 5

    for i = -180, 180, 1 do
        local angle = math.floor((headingLerp + i) % 360)
        local offset = i * pixelsPerDegree
        local alpha = 255 * (1 - math.min(math.abs(offset) / fadeRange, 1))

        if ( alpha <= 5 ) then continue end
        if ( angle % 5 != 0 ) then continue end -- only show every 5°

        local label = directionLabels[angle]
        local text = label or tostring(angle)
        local font = label and "ax.large.bold" or "ax.small"

        surface.SetTextColor(255, 255, 255, alpha)
        surface.SetFont(font)
        local textW = surface.GetTextSize(text)
        surface.SetTextPos(centerX + offset - textW / 2, centerY)
        surface.DrawText(text)
    end

    -- Compass marker
    draw.SimpleText("v", "ax.large.bold", centerX, centerY - 20, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
end

function CurvyHUDDemo:DrawSquadInfo(width, height, client)
    local x, y = ScreenScale(16), height - ScreenScaleH(16)

    -- Calculate starting Y
    y = y - draw.GetFontHeight("ax.large.bold")
    for i = 1, #squadMembers do
        y = y - draw.GetFontHeight("ax.regular")
    end

    -- Header
    local header = ":: SQUAD STATUS ::"
    local squadIcon = ax.curvy:LoadMaterial("icon16/group.png")

    ax.curvy:DrawIcon(squadIcon, x, y + ScreenScaleH(6),
        ScreenScaleH(8), Color(100, 255, 100),
        TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

    draw.SimpleText(header, "ax.large.bold", x + ScreenScaleH(14), y,
        Color(100, 255, 100), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    y = y + draw.GetFontHeight("ax.large.bold")

    -- Squad members
    for i, member in ipairs(squadMembers) do
        local color = (i == 1) and Color(255, 255, 100) or Color(200, 255, 200)
        draw.SimpleText("• " .. member, "ax.regular", x, y, color,
            TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        y = y + draw.GetFontHeight("ax.regular")
    end
end

function CurvyHUDDemo:DrawAmmoCounter(width, height, client)
    local x, y = width - ScreenScale(16), height - ScreenScaleH(16)
    local weapon = client:GetActiveWeapon()

    if ( !IsValid(weapon) ) then return end

    local clip = weapon:Clip1()
    local ammoType = weapon:GetPrimaryAmmoType()
    local reserve = client:GetAmmoCount(ammoType)

    surface.SetFont("ax.regular")
    local space = surface.GetTextSize(tostring(reserve)) + ScreenScale(4)

    -- Ammo icon
    local ammoIcon = ax.curvy:LoadMaterial("icon16/bullet_black.png")
    ax.curvy:DrawIcon(ammoIcon, x - space - ScreenScaleH(16),
        y - ScreenScaleH(2), ScreenScaleH(14),
        color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)

    -- Ammo text
    draw.SimpleText(clip, "ax.large.bold", x - space, y, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
    draw.SimpleText(reserve, "ax.regular", x, y, Color(150, 150, 150), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
end

---------------------------------------
-- Main HUD Function
---------------------------------------
hook.Add("HUDPaintCurvy", "CurvyHUDDemo.Draw", function(width, height, client)
    if ( !GetConVar("ax_demo_curvy_hud"):GetBool() ) then return end

    CurvyHUDDemo:DrawGeneralInfo(width, height, client)
    CurvyHUDDemo:DrawCompass(width, height, client)
    CurvyHUDDemo:DrawSquadInfo(width, height, client)
    CurvyHUDDemo:DrawAmmoCounter(width, height, client)
end)
