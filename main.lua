NullDimension = RegisterMod("Null Dimension", 1)
local mod = NullDimension

--[[ Load scripts ]]--
function mod:LoadScripts(scripts, subfolder)
	subfolder = subfolder or ""
	for i, script in pairs(scripts) do
		include("trinket_scripts." .. subfolder .. "." .. script)
	end
end

-- General
local generalScripts = {
	"library",
}
mod:LoadScripts(generalScripts)


-- Trinkets
local trinketScripts = {
    "predatorypenny",
    "popupad",
    "steelhelm",
    "wickedbible",
    "buckler",
    "amuletofdawn",
    "spidercocoon",
    "dirtball",
    "smilesticker",
    "spartanrage",
    "keycloner",
    "devilsdelivery",
    "8bitmush",
    "scratchcard",
    "valuabletoken",
    "portablecannon",
    "metalfeather",
    "potatobattery",
    "woodentotem",
    "frictionfiction",
    "collectablecard",
    "chameleonseye",
    "caramelbean",
}
mod:LoadScripts(trinketScripts, "trinkets")

include("eid")