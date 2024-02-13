local frame = CreateFrame("StatusBar", "ManaBar", PlayerFrame)
frame:SetSize(100, 9)  -- width, height

frame:SetPoint("TOP", PlayerFrame, "BOTTOM", 50, 35)

frame:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")

frame:SetStatusBarColor(0, 0, 1)

local bg = frame:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints(true)
bg:SetColorTexture(0.5, 0.5, 0.5, 0.5)

local maxMana = UnitPowerMax("player", 0)
frame:SetMinMaxValues(0, maxMana)

local currentMana = UnitPower("player", 0)
frame:SetValue(currentMana)

frame:SetScript("OnUpdate", function(self, elapsed)
    self.timeSinceLastUpdate = (self.timeSinceLastUpdate or 0) + elapsed

    if self.timeSinceLastUpdate >= 1 then  -- in seconds
        local currentMana = UnitPower("player", 0)
        self:SetValue(currentMana)
        self.timeSinceLastUpdate = 0

    end
end)