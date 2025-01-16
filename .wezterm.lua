-- Pull in the wezterm API
local wezterm = require 'wezterm'
local io = require 'io'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.hide_tab_bar_if_only_one_tab = true
config.force_reverse_video_cursor = true
config.font_size = 13

config.font = wezterm.font( 'ComicShannsMono Nerd Font' )
--config.font = wezterm.font( 'Andale Mono' )

config.harfbuzz_features = {"calt=0", "clig=0", "liga=0"}
config.audible_bell = "Disabled"
config.window_close_confirmation = 'NeverPrompt'

config.use_dead_keys = true -- tilde on macos
config.foreground_text_hsb = {hue = 1.0,saturation = 1.1,brightness = 1.3}

if string.find(wezterm.target_triple, 'windows') ~= nil then
  myenv="windows"
  front_end="Software"
  winenv=os.getenv("HOMEDRIVE")..os.getenv("HOMEPATH")
  config.default_prog = { winenv .. '\\scoop\\apps\\git\\current\\bin\\bash.exe', '-l' }
end
if string.find(wezterm.target_triple, 'linux') ~= nil then
  myenv="linux"
end
if string.find(wezterm.target_triple, 'apple') ~= nil then
  myenv="apple"
  config.window_decorations = "TITLE|RESIZE|MACOS_FORCE_DISABLE_SHADOW"
  config.send_composed_key_when_left_alt_is_pressed = true
end

config.keys = {
  -- Turn off non-breaking spaces in wezterm on MacOS
  {
    key = ' ',
    mods = 'OPT',
    action = wezterm.action.SendKey { key = ' '},
  },

  {
    key = 'w',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
}

config.color_scheme = 'Builtin Dark'
-- config.color_scheme = 'Builtin Light'
-- config.color_scheme = 'Builtin Solarized Dark'
-- config.color_scheme = 'Builtin Solarized Light'
config.color_scheme = "OneDark (base16)"

-- and finally, return the configuration to wezterm
return config

