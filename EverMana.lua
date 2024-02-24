local frame = CreateFrame("StatusBar", "ManaBar", PlayerFrame)
frame:SetSize(100, 9)  -- width, height
frame:SetPoint("TOP", PlayerFrame, "BOTTOM", 50, 33)
frame:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
frame:SetStatusBarColor(0, 0, 1)

local bg = frame:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints(true)
bg:SetColorTexture(0.5, 0.5, 0.5, 0.5)

local maxMana = UnitPowerMax("player", 0)
frame:SetMinMaxValues(0, maxMana)

local currentMana = UnitPower("player", 0)
frame:SetValue(currentMana)

local valueText = frame:CreateFontString(nil, "OVERLAY")
valueText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
valueText:SetPoint("CENTER", frame, "CENTER", 0, 0)

local updateFrame = CreateFrame("Frame")
updateFrame:Hide()

updateFrame:SetScript("OnUpdate", function(self, elapsed)
    self.timeSinceLastUpdate = (self.timeSinceLastUpdate or 0) + elapsed

    if self.timeSinceLastUpdate >= 1 then  -- in seconds
        local currentMana = UnitPower("player", 0)
        frame:SetValue(currentMana)
        valueText:SetText(currentMana)

        self.timeSinceLastUpdate = 0

        local spellName = "Cat Form"
        local spellId = select(7, GetSpellInfo(spellName))
        local costInfo = GetSpellPowerCost(spellId)

        if currentMana < costInfo[1].cost then  -- Change 100 to your desired value
            frame:SetStatusBarColor(1, 0, 0)  -- Red
        else
            frame:SetStatusBarColor(0, 0, 1)  -- Blue
        end

        local hasAura = false
        for i = 1, 40 do
            local name = UnitAura("player", i)
            if name == "Cat Form" or name == "Bear Form" then
                hasAura = true
                break
            end
        end

        if hasAura then
            -- If the player has the aura, show the mana bar
            frame:Show()
            -- print("Cat Form detected, showing mana bar.")
        else
            -- If the player doesn't have the aura, hide the mana bar
            frame:Hide()
            -- print("Cat Form not detected, hiding mana bar.")
        end

    end
end)

updateFrame:Show()