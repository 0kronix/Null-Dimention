---- Constants ----

local mod = NullDimension
local game = Game()
local MetalFeather = {}

MetalFeather.id = Isaac.GetTrinketIdByName("Metal Feather")
MetalFeather.DMG = 0.02
MetalFeather.NeedDMG = 4

---- Descriptions ----

MetalFeather.description = {
	"↑ {{Damage}} +".. MetalFeather.DMG .." Damage after clearing ".. MetalFeather.NeedDMG .." rooms in a row without taking damage",
    "↓ Taking damage halves current bonus",
    "{{Warning}} Taking damage counts only in uncleared rooms"
}
MetalFeather.description_ru = {
    "↑ {{Damage}} +".. MetalFeather.DMG .." Урона после зачистки ".. MetalFeather.NeedDMG .." комнат подряд без получения урона",
    "↓ Получение урона снижает текущий бонус вдвое",
    "{{Warning}} Получение урона считается только в незачищенных комнатах"
}
mod:CreateEID(MetalFeather.id, MetalFeather.description, "Metal Feather")
mod:CreateEID(MetalFeather.id, MetalFeather.description_ru, "Металлическое перо", "ru")

MetalFeather.goldenData = {
    Numbers = {MetalFeather.DMG},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
MetalFeather.goldenData_ru = {
    Numbers = {MetalFeather.DMG},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    MetalFeather.id,
    MetalFeather.goldenData.Numbers,
    MetalFeather.goldenData.ExtraText,
    MetalFeather.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    MetalFeather.id,
    MetalFeather.goldenData_ru.Numbers,
    MetalFeather.goldenData_ru.ExtraText,
    MetalFeather.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function MetalFeather:roomClear()
    local player = game:GetPlayer()
    local data = player:GetData()

    data.metalDMG = data.metalDMG or 0
    data.metalCount = data.metalCount or 0
    data.isMetalDMG = data.isMetalDMG or false

    if player:HasTrinket(MetalFeather.id) then
        if not data.isMetalDMG then
            data.metalDMG = data.metalDMG + 1

            if data.metalDMG >= MetalFeather.NeedDMG then
                data.metalDMG = 0
                data.metalCount = data.metalCount + MetalFeather.DMG

                player:AddCacheFlags(CacheFlag.CACHE_DAMAGE, true)
            end
        else
            data.isMetalDMG = false
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, MetalFeather.roomClear)

function MetalFeather:entityTakeDMG(entity, _, _, _, _)
    local player = entity:ToPlayer()
    local room = game:GetRoom()
    local data = player:GetData()

    data.metalCount = data.metalCount or 0
    data.isMetalDMG = data.isMetalDMG or false

    if player:HasTrinket(MetalFeather.id) and not room:IsClear() then
        data.isMetalDMG = true
        data.metalCount = math.ceil(data.metalCount / 2)

        player:AddCacheFlags(CacheFlag.CACHE_DAMAGE, true)
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, MetalFeather.entityTakeDMG, EntityType.ENTITY_PLAYER)

function MetalFeather:onCache(player, cacheFlag)
    if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
        if player:HasTrinket(MetalFeather.id) then
            local data = player:GetData()
            local mult = player:GetTrinketMultiplier(MetalFeather.id)

            data.metalCount = data.metalCount or 0
            player.Damage = player.Damage + data.metalCount * mult
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, MetalFeather.onCache)