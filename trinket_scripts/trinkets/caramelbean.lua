---- Constants ----

local mod = NullDimension
local game = Game()
local CaramelBean = {}

CaramelBean.id = Isaac.GetTrinketIdByName("Caramel Bean")
CaramelBean.Chance = 6

---- Descriptions ----

CaramelBean.description = {
	"Enemies have ".. CaramelBean.Chance .."% to fart upon death"
}
CaramelBean.description_ru = {
    "Враги имеют шанс ".. CaramelBean.Chance .."% пукнуть после смерти"
}
mod:CreateEID(CaramelBean.id, CaramelBean.description, "Caramel Bean")
mod:CreateEID(CaramelBean.id, CaramelBean.description_ru, "Карамельный боб", "ru")

CaramelBean.goldenData = {
    Numbers = {CaramelBean.Chance},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
CaramelBean.goldenData_ru = {
    Numbers = {CaramelBean.Chance},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    CaramelBean.id,
    CaramelBean.goldenData.Numbers,
    CaramelBean.goldenData.ExtraText,
    CaramelBean.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    CaramelBean.id,
    CaramelBean.goldenData_ru.Numbers,
    CaramelBean.goldenData_ru.ExtraText,
    CaramelBean.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function CaramelBean:postNPCDeath(entity)
    if PlayerManager.AnyoneHasTrinket(CaramelBean.id) then
        local mult = PlayerManager.GetTotalTrinketMultiplier(CaramelBean.id)

        if entity:IsEnemy() and mod:trinketProbCheck(player, CaramelBean.id, CaramelBean.Chance * mult) then
            game:Fart(entity.Position, 85, entity, 1, 0, Color.Default)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, CaramelBean.postNPCDeath)