---- Constants ----

local mod = NullDimention
local game = Game()
local Buckler = {}

Buckler.id = Isaac.GetTrinketIdByName("Buckler")
Buckler.Sec = 1

---- Descriptions ----

Buckler.description = {
	"{{Timer}} Gives an invincibility for ".. Buckler.Sec .." second(s) after entering to the uncleared room"
}
Buckler.description_ru = {
    "{{Timer}} Даёт невосприимчивость к урону на ".. Buckler.Sec .." секунд(у/ы) при входе в незачищенную комнату"
}
mod:CreateEID(Buckler.id, Buckler.description, "Buckler")
mod:CreateEID(Buckler.id, Buckler.description_ru, "Баклер", "ru")

Buckler.goldenData = {
    Numbers = {Buckler.Sec},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
Buckler.goldenData_ru = {
    Numbers = {Buckler.Sec},
    ExtraText = {
        Doubled = "",
        Tripled = "",
    },
    MaxMultiplier = nil,
}
mod:AddEIDGoldenTrinketData(
    Buckler.id,
    Buckler.goldenData.Numbers,
    Buckler.goldenData.ExtraText,
    Buckler.goldenData.MaxMultiplier )
mod:AddEIDGoldenTrinketData(
    Buckler.id,
    Buckler.goldenData_ru.Numbers,
    Buckler.goldenData_ru.ExtraText,
    Buckler.goldenData_ru.MaxMultiplier,
    "ru" )

---- Effects ----

function Buckler:roomEnter()
    local player = game:GetPlayer()
    local room = game:GetRoom()

    if player:HasTrinket(Buckler.id) then
        local mult = player:GetTrinketMultiplier(Buckler.id)
        local sec = Buckler.Sec * 60 * mult

        if not room:IsClear() then
            SFXManager():Play(SoundEffect.SOUND_SCYTHE_BREAK, 1)
            player:SetMinDamageCooldown(sec)
            player:SetColor(Color(1, 1, 1, 0.5), sec / 2, 0, false, false)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Buckler.roomEnter)