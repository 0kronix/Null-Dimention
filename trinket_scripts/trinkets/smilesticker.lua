---- Constants ----

local mod = NullDimension
local game = Game()
local SmileSticker = {}

SmileSticker.id = Isaac.GetTrinketIdByName("Smile Sticker")
SmileSticker.Chance = 15

---- Descriptions ----

SmileSticker.description = {
	"{{Trinket}} ".. SmileSticker.Chance .."% chance to spawn a random trinket upon defeating the floor's boss"
}
SmileSticker.description_ru = {
    "{{Trinket}} ".. SmileSticker.Chance .."% шанс создать случайный брелок после победы над боссом этажа"
}
mod:CreateEID(SmileSticker.id, SmileSticker.description, "Smile Sticker")
mod:CreateEID(SmileSticker.id, SmileSticker.description_ru, "Стикер улыбки", "ru")

SmileSticker.goldenData = {
    Numbers = {SmileSticker.Chance},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
SmileSticker.goldenData_ru = {
    Numbers = {SmileSticker.Chance},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    SmileSticker.id,
    SmileSticker.goldenData.Numbers,
    SmileSticker.goldenData.ExtraText,
    SmileSticker.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    SmileSticker.id,
    SmileSticker.goldenData_ru.Numbers,
    SmileSticker.goldenData_ru.ExtraText,
    SmileSticker.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function SmileSticker:onBossDefeat(_, spawnPos)
    local player = game:GetPlayer()

    if player:HasTrinket(SmileSticker.id) then
        local room = game:GetRoom()
        local level = game:GetLevel()

        if room:GetType() == RoomType.ROOM_BOSS and ((level:GetStageType() <= StageType.STAGETYPE_AFTERBIRTH and level:GetStage() <= LevelStage.STAGE4_2) or (level:GetStageType() >= StageType.STAGETYPE_REPENTANCE and level:GetStage() <= LevelStage.STAGE4_1)) then
            local mult = player:GetTrinketMultiplier(SmileSticker.id)

            if mod:trinketProbCheck(player, SmileSticker.id, SmileSticker.Chance * mult) then
                local pos = player:HasCollectible(CollectibleType.COLLECTIBLE_THERES_OPTIONS) and (spawnPos + Vector(120, 40)) or (spawnPos + Vector(80, 40))

                Isaac.Spawn(5, 350, 0, room:FindFreePickupSpawnPosition(pos, 35), Vector(0, 0), player):ToPickup()
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, SmileSticker.onBossDefeat)