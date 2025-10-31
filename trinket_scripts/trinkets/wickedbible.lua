---- Constants ----

local mod = NullDimention
local game = Game()
local WickedBible = {}

WickedBible.id = Isaac.GetTrinketIdByName("Wicked Bible")
WickedBible.Chance = 16

---- Descriptions ----

WickedBible.description = {
	"{{Collectible33}} ".. WickedBible.Chance .."% chance for The Bible effect and take half a heart damage to Isaac upon clearing a room"
}
WickedBible.description_ru = {
    "{{Collectible33}} ".. WickedBible.Chance .."% шанс на эффект Библии и получение урона в половину сердца после зачистки комнаты"
}
mod:CreateEID(WickedBible.id, WickedBible.description, "Wicked Bible")
mod:CreateEID(WickedBible.id, WickedBible.description_ru, "Злая Библия", "ru")

WickedBible.goldenData = {
    Numbers = {WickedBible.Chance},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
WickedBible.goldenData_ru = {
    Numbers = {WickedBible.Chance},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    WickedBible.id,
    WickedBible.goldenData.Numbers,
    WickedBible.goldenData.ExtraText,
    WickedBible.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    WickedBible.id,
    WickedBible.goldenData_ru.Numbers,
    WickedBible.goldenData_ru.ExtraText,
    WickedBible.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function WickedBible:roomClear()
    local player = game:GetPlayer()

    if player:HasTrinket(WickedBible.id) then
        local mult = player:GetTrinketMultiplier(WickedBible.id)

        if mod:trinketProbCheck(player, WickedBible.id, WickedBible.Chance * mult) then
            SFXManager():Play(SoundEffect.SOUND_HOLY, 0.5)
            player:UseActiveItem(CollectibleType.COLLECTIBLE_BIBLE, UseFlag.USE_MIMIC)

            player:ResetDamageCooldown()
            player:TakeDamage(1, DamageFlag.DAMAGE_INVINCIBLE | DamageFlag.DAMAGE_NO_MODIFIERS | DamageFlag.DAMAGE_NO_PENALTIES, EntityRef(player), 24)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, WickedBible.roomClear)