---- Constants ----

local mod = NullDimention
local game = Game()
local SteelHelm = {}

SteelHelm.id = Isaac.GetTrinketIdByName("Steel Helm")
SteelHelm.Hits = 10
SteelHelm.Count = 0

---- Descriptions ----

SteelHelm.description = {
	"{{SoulHeart}} Spawn half a Soul Heart each ".. SteelHelm.Hits .."th damage taken"
}
SteelHelm.description_ru = {
    "{{SoulHeart}} Создаёт половину Сердца Души каждый ".. SteelHelm.Hits .."-ый полученный урон"
}
mod:CreateEID(SteelHelm.id, SteelHelm.description, "Steel Helm")
mod:CreateEID(SteelHelm.id, SteelHelm.description_ru, "Стальной Шлем", "ru")

SteelHelm.goldenData = {
    Numbers = {},
    ExtraText = {
        Doubled = "{{SoulHeart}} Spawn full Soul Heart",
        Tripled = "{{SoulHeart}} Spawn full Soul Heart",
    },
    MaxMultiplier = nil,
}
SteelHelm.goldenData_ru = {
    Numbers = {},
    ExtraText = {
        Doubled = "{{SoulHeart}} Создаёт полное Сердце Души",
        Tripled = "{{SoulHeart}} Создаёт полное Сердце Души",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    SteelHelm.id,
    SteelHelm.goldenData.Numbers,
    SteelHelm.goldenData.ExtraText,
    SteelHelm.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    SteelHelm.id,
    SteelHelm.goldenData_ru.Numbers,
    SteelHelm.goldenData_ru.ExtraText,
    SteelHelm.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function SteelHelm:entityTakeDMG(entity, _, _, _, _)
    local player = entity:ToPlayer()
    local room = game:GetRoom()

    if player:HasTrinket(SteelHelm.id) then
        SteelHelm.Count = SteelHelm.Count + 1
        local mult = player:GetTrinketMultiplier(SteelHelm.id)

        if SteelHelm.Count >= SteelHelm.Hits then
            SteelHelm.Count = 0

            local freePos = room:FindFreePickupSpawnPosition(mod:GetRandomAroundPosition(player.Position), 0, true)

            local heart = mult >= 2 and HeartSubType.HEART_SOUL or HeartSubType.HEART_HALF_SOUL

            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, heart, freePos, Vector(0,0), nil)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, SteelHelm.entityTakeDMG, EntityType.ENTITY_PLAYER)