---- Constants ----

local mod = NullDimension
local game = Game()
local PortableCannon = {}

PortableCannon.id = Isaac.GetTrinketIdByName("Portable Cannon")

---- Descriptions ----

PortableCannon.description = {
	"Spawn a throwable bomb upon entering {{BossRoom}} Boss Room"
}
PortableCannon.description_ru = {
    "Создаёт бросаемую бомбу при входе в {{BossRoom}} Комнату Босса"
}
mod:CreateEID(PortableCannon.id, PortableCannon.description, "Portable Cannon")
mod:CreateEID(PortableCannon.id, PortableCannon.description_ru, "Переносная пушка", "ru")

PortableCannon.goldenData = {
    Numbers = {},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
PortableCannon.goldenData_ru = {
    Numbers = {},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    PortableCannon.id,
    PortableCannon.goldenData.Numbers,
    PortableCannon.goldenData.ExtraText,
    PortableCannon.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    PortableCannon.id,
    PortableCannon.goldenData_ru.Numbers,
    PortableCannon.goldenData_ru.ExtraText,
    PortableCannon.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function PortableCannon:bossRoomEnter()
    local player = game:GetPlayer()
    local room = game:GetRoom()

    if player:HasTrinket(PortableCannon.id) then
        if room:GetType() == RoomType.ROOM_BOSS then
            Isaac.Spawn(EntityType.ENTITY_PICKUP    , PickupVariant.PICKUP_THROWABLEBOMB, 0, 
                room:FindFreePickupSpawnPosition(room:GetRandomPosition(35)), Vector(0,0), nil)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, PortableCannon.bossRoomEnter)