NullDimention = RegisterMod("Null Dimention", 1)
local mod = NullDimention

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
}
mod:LoadScripts(trinketScripts, "trinkets")

include("eid")