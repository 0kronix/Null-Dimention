---- Constants ----

local mod = NullDimension
local game = Game()
local SpartanRage = {}

SpartanRage.id = Isaac.GetTrinketIdByName("Spartan Rage")
SpartanRage.DMG = 0.8

---- Descriptions ----

SpartanRage.description = {
	"{{Damage}} +".. SpartanRage.DMG .." Damage in 2x2 rooms"
}
SpartanRage.description_ru = {
    "{{Damage}} +".. SpartanRage.DMG .." Урона в 2x2 комнатах"
}
mod:CreateEID(SpartanRage.id, SpartanRage.description, "Spartan Rage")
mod:CreateEID(SpartanRage.id, SpartanRage.description_ru, "Ярость Спарты", "ru")

SpartanRage.goldenData = {
    Numbers = {SpartanRage.DMG},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
SpartanRage.goldenData_ru = {
    Numbers = {SpartanRage.DMG},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    SpartanRage.id,
    SpartanRage.goldenData.Numbers,
    SpartanRage.goldenData.ExtraText,
    SpartanRage.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    SpartanRage.id,
    SpartanRage.goldenData_ru.Numbers,
    SpartanRage.goldenData_ru.ExtraText,
    SpartanRage.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function SpartanRage:roomEnter()
    local player = game:GetPlayer()
    local room = game:GetRoom()

    if player:HasTrinket(SpartanRage.id) then
        if room:GetRoomShape() == RoomShape.ROOMSHAPE_2x2 then
            local mult = player:GetTrinketMultiplier(SpartanRage.id)
            local data = player:GetData()

            data.sparta = data.sparta or 0
            data.sparta = SpartanRage.DMG * mult

            player:AddCacheFlags(CacheFlag.CACHE_DAMAGE, true)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, SpartanRage.roomEnter)

function SpartanRage:postPlayerNewRoom(player)
    local room = game:GetRoom()

    if room:GetRoomShape() ~= RoomShape.ROOMSHAPE_2x2 then
        player:GetData().sparta = 0
        player:AddCacheFlags(CacheFlag.CACHE_DAMAGE, true)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_ROOM_TEMP_EFFECTS, SpartanRage.postPlayerNewRoom)

function SpartanRage:onCache(player, cacheFlag)
    if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
        if player:HasTrinket(SpartanRage.id) then
            local data = player:GetData()
            data.sparta = data.sparta or 0
            player.Damage = player.Damage + data.sparta
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, SpartanRage.onCache)