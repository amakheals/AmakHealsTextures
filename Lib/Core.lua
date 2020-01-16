local AddonName, AmakHealsTextures = ...

--WoW API / Variables
local GetAddOnInfo = GetAddOnInfo
local GetBuildInfo = GetBuildInfo

-- configure addon data
AmakHealsTextures.Name = select(1, GetAddOnInfo(AddonName))
AmakHealsTextures.Build = select(4, GetBuildInfo())
AmakHealsTextures.Author = select(3, GetAddOnInfo(AddonName))
AmakHealsTextures.AddonTitle = select(2, GetAddOnInfo(AddonName))
AmakHealsTextures.PlainAddonTitle = AmakHealsTextures.AddonTitle:gsub("|c........", ""):gsub("|r", "")
AmakHealsTextures.AddonTitleHeader = "|cFFFEFEFE["..AmakHealsTextures.PlainAddonTitle.."]|r"

-- check for addon out of date logic
function AmakHealsTextures.BuildFail(Min, Over)
	return AmakHealsTextures.Build < (Min or 0) or ( (Over or 0) > 0 and AmakHealsTextures.Build >= Over )
end

-- debug print function
function AmakHealsTextures.print(msg)
	return print(AmakHealsTextures.AddonTitleHeader .. ": " .. msg)
end

-- addon paths

-- internal path function
function AmakHealsTextures.getDir(dirstub)
	if not dirstub then dirstub = "" end
	local path = "Interface\\" .. "AddOns" AmakHealsTextures.Name
        return print(AmakHealsTextures.AddonTitleHeader .. ": " .. msg)
end
