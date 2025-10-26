NullDimention = RegisterMod("Null Dimention", 1)
mod = NullDimention



--[[ Load scripts ]]--
function mod:LoadScripts(scripts, subfolder)
	subfolder = subfolder or ""
	for i, script in pairs(scripts) do
		include("trinket_scripts." .. subfolder .. "." .. script)
	end
end


-- General
local generalScripts = {
	"constants",
	"library",
}
mod:LoadScripts(generalScripts)


-- Trinkets
local trinketScripts = { -- Add trinket scripts here
    "dentalion",
}
mod:LoadScripts(trinketScripts, "trinkets")