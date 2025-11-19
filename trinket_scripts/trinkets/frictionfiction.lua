---- Constants ----

local mod = NullDimention
local game = Game()
local FrictionFiction = {}

FrictionFiction.id = Isaac.GetTrinketIdByName("Friction Fiction")
FrictionFiction.Speed = 0.2
FrictionFiction.ShotSpeed = 0.4

---- Descriptions ----

FrictionFiction.description = {
	"↓ {{Speed}} -".. FrictionFiction.Speed .." Speed",
    "↑ {{Shotspeed}} +".. FrictionFiction.ShotSpeed .." Shot speed"
}
FrictionFiction.description_ru = {
    "↓ {{Speed}} -".. FrictionFiction.Speed .." к Скорости",
    "↑ {{Shotspeed}} +".. FrictionFiction.ShotSpeed .." к Скорости слезы"
}
mod:CreateEID(FrictionFiction.id, FrictionFiction.description, "Friction Fiction")
mod:CreateEID(FrictionFiction.id, FrictionFiction.description_ru, "Фантастика о трении", "ru")

FrictionFiction.goldenData = {
    Numbers = {FrictionFiction.ShotSpeed},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
FrictionFiction.goldenData_ru = {
    Numbers = {FrictionFiction.ShotSpeed},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    FrictionFiction.id,
    FrictionFiction.goldenData.Numbers,
    FrictionFiction.goldenData.ExtraText,
    FrictionFiction.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    FrictionFiction.id,
    FrictionFiction.goldenData_ru.Numbers,
    FrictionFiction.goldenData_ru.ExtraText,
    FrictionFiction.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function FrictionFiction:OnCache(player, cacheFlags)
    if player:HasTrinket(FrictionFiction.id) then
        local mult = player:GetTrinketMultiplier(FrictionFiction.id)

        if cacheFlags & CacheFlag.CACHE_SPEED > 0 then
            player.MoveSpeed = player.MoveSpeed - FrictionFiction.Speed
        end
        if cacheFlags & CacheFlag.CACHE_SHOTSPEED > 0 then
            player.ShotSpeed = player.ShotSpeed + FrictionFiction.ShotSpeed * mult
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, FrictionFiction.OnCache)