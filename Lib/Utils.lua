local AddonName, AmakHealsTextures = ...
if AmakHealsTextures.BuildFail(80000) then return end

-- check for optional dependency WeakAuras2
if IsAddOnLoaded("WeakAuras2") then
	if not WeakAuras then
		AmakHealsTextures.print("Can't Find Optional Dependencys")
	else
		WeakAuras.RegisterAddon(AddonName, AmakHealsTextures.PlainAddonTitle, "Data sourced from "..AmakHealsTextures.PlainAddonTitle, "Interface\\Addons\\"..AmakHealsTextures.name.."\\MiscTexturePack\\logo.blp")
	end
-- local spellsTextureMap = {}

end