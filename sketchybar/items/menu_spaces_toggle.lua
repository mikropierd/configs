local constants = require("constants")
local settings = require("config.settings")

sbar.add("event", constants.events.SWAP_MENU_AND_SPACES)

local function switchToggle(menuToggle)
  local isShowingMenu = menuToggle:query().icon.value == settings.icons.text.switch.off

  menuToggle:set({
    icon = isShowingMenu and settings.icons.text.switch.off or settings.icons.text.switch.off,
    label = isShowingMenu and "Menus" or "Spaces",
  })

  sbar.trigger(constants.events.SWAP_MENU_AND_SPACES, { isShowingMenu = isShowingMenu })
end

