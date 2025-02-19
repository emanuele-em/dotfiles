local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.font = wezterm.font "FiraCode Nerd Font"
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' } --disable ligatures
-- config.font_size = 10.0
-- config.audible_bell = "Disabled"
config.color_scheme = 'Gruvbox dark, hard (base16)'
config.colors = {
  selection_bg = "rgba:50% 50% 50% 50%",
  selection_fg = 'none'
}
config.scrollback_lines = 10000

-- open full screen on startup
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

config.keys = {
  {
    key = '%',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '"',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'x',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = 'd',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.PaneSelect
  },
  {
    key = 'h',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'k',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'j',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key="t",
    mods="CTRL|SHIFT",
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentTab { confirm = true },
  },
  {
      key = 'p', 
      mods = 'CTRL|SHIFT', 
      action = wezterm.action.ActivateTabRelative(-1) 
  },
  { 
      key = 'n', 
      mods = 'CTRL|SHIFT', 
      action = wezterm.action.ActivateTabRelative(1) 
  },
}

return config
