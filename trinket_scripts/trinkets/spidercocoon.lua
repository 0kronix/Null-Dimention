---- Constants ----

local mod = NullDimension
local game = Game()
local SpiderCocoon = {}

SpiderCocoon.id = Isaac.GetTrinketIdByName("Spider Cocoon")

---- Descriptions ----

SpiderCocoon.description = {
	"Turn all {{Coin}} Pennies in room into blue spider upon taking damage"
}
SpiderCocoon.description_ru = {
    "Превращает все {{Coin}} Пенни в комнате в синих пауков при получении урона"
}
mod:CreateEID(SpiderCocoon.id, SpiderCocoon.description, "Spider Cocoon")
mod:CreateEID(SpiderCocoon.id, SpiderCocoon.description_ru, "Паучий кокон", "ru")

SpiderCocoon.goldenData = {
    Numbers = {SpiderCocoon.Chance},
    ExtraText = {
        Doubled = "Spawn 2 spiders",
        Tripled = "Spawn 3 spiders",
    },
    MaxMultiplier = nil,
}
SpiderCocoon.goldenData_ru = {
    Numbers = {SpiderCocoon.Chance},
    ExtraText = {
        Doubled = "Появляется 2 паука",
        Tripled = "Появляется 3 паука",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    SpiderCocoon.id,
    SpiderCocoon.goldenData.Numbers,
    SpiderCocoon.goldenData.ExtraText,
    SpiderCocoon.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    SpiderCocoon.id,
    SpiderCocoon.goldenData_ru.Numbers,
    SpiderCocoon.goldenData_ru.ExtraText,
    SpiderCocoon.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function SpiderCocoon:entityTakeDMG(entity, _, _, _, _)
    local player = entity:ToPlayer()

    if player:HasTrinket(SpiderCocoon.id) then
        for k, v in pairs(Isaac.FindByType(5, 20, 1)) do
            local pickup = v:ToPickup()
            local pos = pickup.Position

            pickup:Remove()
            for _ = 1, player:GetTrinketMultiplier(SpiderCocoon.id) do
                player:AddBlueSpider(pos)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, SpiderCocoon.entityTakeDMG, EntityType.ENTITY_PLAYER)