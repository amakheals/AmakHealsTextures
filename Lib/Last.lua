-- DO NOT EDIT THIS FILE --
local AddonName, AmakHealsTextures = ...
if AmakHealsTextures.BuildFail(80300) then
	print("AmakHealsTextures: " .. "Failed to Load")
	return
else
	-- attempt to laod addon as evn var
	_G[AddonName] = AmakHealsTextures
	AmakHealsTextures.print("Successfully Loaded")
end
-- DO NOT EDIT THIS FILE --
