---- Constants ----

local mod = NullDimention
local game = Game()
local CaramelBean = {}

CaramelBean.id = Isaac.GetTrinketIdByName("Caramel Bean")
CaramelBean.Chance = 6

---- Descriptions ----

CaramelBean.description = {
	""
}
CaramelBean.description_ru = {
    ""
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

function LDLm:PostNPCDeath(entityNPC)
    if PlayerManager.AnyoneHasCollectible(CaramelBean.id) then
        
    end
end

LDLm:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, LDLm.PostNPCDeath)