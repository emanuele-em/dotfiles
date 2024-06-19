local wezterm = require 'wezterm'

local config = wezterm.config_builder()

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

config.color_scheme = 'Gruvbox dark, hard (base16)'

return config
