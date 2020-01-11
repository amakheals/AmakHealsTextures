local AddonName, AmakHealsTextures = ...
AmakHealsTextures.Name = select(1, GetAddOnInfo(AddonName))
AmakHealsTextures.Build = select(4, GetBuildInfo(AddonName))
AmakHealsTextures.Author = select(3, GetAddOnInfo(AddonName))
AmakHealsTextures.AddonTitle = select(2, GetAddOnInfo(AddonName))
AmakHealsTextures.PlainAddonTitle = AmakHealsTextures.AddonTitle:gsub("|c........", ""):gsub("|r", "")
AmakHealsTextures.AddonTitleHeader = "|cFFFEFEFE["..AmakHealsTextures.PlainAddonTitle.."]|r"

-- check for addon out of date logic
function AmakHealsTextures.BuildFail(Min, Over)
	return AmakHealsTextures.Build < (Min or 0) or ( (Over or 0) > 0 and AmakHealsTextures.Build >= Over )
end

-- debug print function
function AmakHealsTextures.print(...)
	return print(AmakHealsTextures.AddonTitleHeader .. ": " .. ...)
end
