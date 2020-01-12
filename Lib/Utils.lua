local AddonName, AmakHealsTextures = ...
if AmakHealsTextures.BuildFail(80000) then return end

--WoW API / Variables
local IsAddOnLoaded = IsAddOnLoaded

-- check for optional dependency WeakAuras2
local WeakAuras = WeakAuras
if IsAddOnLoaded("WeakAuras2") then
	if not WeakAuras then
		AmakHealsTextures.print("Can't Find Optional Dependencys")
	else
		AmakHealsTextures.print("Found Optional Dependency: " .. "WeakAuras2")
		WeakAuras.RegisterAddon(AddonName, AmakHealsTextures.PlainAddonTitle, "Data sourced from "..AmakHealsTextures.PlainAddonTitle, "Interface\\Addons\\"..AmakHealsTextures.name.."\\MiscTexturePack\\logo.blp")
	end
-- local spellsTextureMap = {}

end