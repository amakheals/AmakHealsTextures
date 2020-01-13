local AddonName, AmakHealsTextures = ...
if AmakHealsTextures.BuildFail(80000) then return end

--WoW API / Variables
local IsAddOnLoaded = IsAddOnLoaded

-- check for optional dependency WeakAuras
if not select(1, IsAddOnLoaded("WeakAuras")) then
	loaded, reason = LoadAddOn("WeakAuras")
	if not loaded then
		AmakHealsTextures.print("Can't Load Optional Dependencys: " .. "WeakAuras")
	end
end
local WeakAuras = WeakAuras
if select(1, IsAddOnLoaded("WeakAuras")) then
	if not WeakAuras then
		AmakHealsTextures.print("Can't Find Optional Dependencys")
	else
		AmakHealsTextures.print("Found Optional Dependency: " .. "WeakAuras")
		WeakAuras.RegisterAddon(AddonName, AmakHealsTextures.PlainAddonTitle, "Data sourced from " .. AmakHealsTextures.PlainAddonTitle, "Interface\\Addons\\" .. AmakHealsTextures.name .. "\\MiscTexturePack\\Logo.blp")
	end
-- local spellsTextureMap = {}
else
	AmakHealsTextures.print("Optional Dependency Not Loaded: " .. "WeakAuras")
end
