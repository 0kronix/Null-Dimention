---- Constants ----

local mod = NullDimention
local game = Game()
local AmuletOfDawn = {}

AmuletOfDawn.id = Isaac.GetTrinketIdByName("Amulet of Dawn")
AmuletOfDawn.Chance = 25

---- Descriptions ----

AmuletOfDawn.description = {
	"Using {{Card20}} The Sun have ".. AmuletOfDawn.Chance .."% chance to spawn {{Card19}} The Moon"
}
AmuletOfDawn.description_ru = {
    "Использование {{Card20}} Солнца имеет шанс ".. AmuletOfDawn.Chance .."% создать {{Card19}} Луну"
}
mod:CreateEID(AmuletOfDawn.id, AmuletOfDawn.description, "Amulet of Dawn")
mod:CreateEID(AmuletOfDawn.id, AmuletOfDawn.description_ru, "Амулет зари", "ru")

AmuletOfDawn.goldenData = {
    Numbers = {AmuletOfDawn.Chance},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
AmuletOfDawn.goldenData_ru = {
    Numbers = {AmuletOfDawn.Chance},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    AmuletOfDawn.id,
    AmuletOfDawn.goldenData.Numbers,
    AmuletOfDawn.goldenData.ExtraText,
    AmuletOfDawn.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    AmuletOfDawn.id,
    AmuletOfDawn.goldenData_ru.Numbers,
    AmuletOfDawn.goldenData_ru.ExtraText,
    AmuletOfDawn.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function AmuletOfDawn:useSun(_, player, _)
    local room = game:GetRoom()

    if player:HasTrinket(AmuletOfDawn.id) then
        local mult = player:GetTrinketMultiplier(AmuletOfDawn.id)

        if mod:trinketProbCheck(player, AmuletOfDawn.id, AmuletOfDawn.Chance * mult) then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, Card.CARD_MOON, 
                mod:GetRandomAroundPosition(player.Position), Vector(0,0), nil)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, AmuletOfDawn.useSun, Card.CARD_SUN)