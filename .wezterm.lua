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
config.font_size =18

config.font_dirs = {'./.wezterm/ComicShannsMono', 'fonts'}
-- config.font = wezterm.font( 'ComicsShann Mono' )
-- config.font = wezterm.font( 'Iosevka Term' )
config.font = wezterm.font( 'JetBrains Mono' )
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
  {
    key = 'w',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
}

-- config.color_scheme = 'Builtin Dark'
-- config.color_scheme = 'Builtin Light'
-- config.color_scheme = 'Builtin Solarized Dark'
-- config.color_scheme = 'Builtin Solarized Light'
-- config.color_scheme = 'AdventureTime'
config.color_scheme = 'Night Owl (Gogh)'

-- -----------------------------
-- config.colors = {
--   -- The default text color
--   foreground = 'silver',
--   -- The default background color
--   background = 'black',

--   -- Overrides the cell background color when the current cell is occupied by the
--   -- cursor and the cursor style is set to Block
--   cursor_bg = '#52ad70',
--   -- Overrides the text color when the current cell is occupied by the cursor
--   cursor_fg = 'black',
--   -- Specifies the border color of the cursor when the cursor style is set to Block,
--   -- or the color of the vertical or horizontal bar when the cursor style is set to
--   -- Bar or Underline.
--   cursor_border = '#52ad70',

--   -- the foreground color of selected text
--   selection_fg = 'black',
--   -- the background color of selected text
--   selection_bg = '#fffacd',

--   -- The color of the scrollbar "thumb"; the portion that represents the current viewport
--   scrollbar_thumb = '#222222',

--   -- The color of the split lines between panes
--   split = '#444444',

--   ansi = {
--     'black',
--     'maroon',
--     'green',
--     'olive',
--     'navy',
--     'purple',
--     'teal',
--     'silver',
--   },
--   brights = {
--     'grey',
--     'red',
--     'lime',
--     'yellow',
--     'blue',
--     'fuchsia',
--     'aqua',
--     'white',
--   },

--   -- Arbitrary colors of the palette in the range from 16 to 255
--   indexed = { [136] = '#af8700' },

--   -- Since: 20220319-142410-0fcdea07
--   -- When the IME, a dead key or a leader key are being processed and are effectively
--   -- holding input pending the result of input composition, change the cursor
--   -- to this color to give a visual cue about the compose state.
--   compose_cursor = 'orange',

--   -- Colors for copy_mode and quick_select
--   -- available since: 20220807-113146-c2fee766
--   -- In copy_mode, the color of the active text is:
--   -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
--   -- 2. selection_* otherwise
--   copy_mode_active_highlight_bg = { Color = '#000000' },
--   -- use `AnsiColor` to specify one of the ansi color palette values
--   -- (index 0-15) using one of the names "Black", "Maroon", "Green",
--   --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
--   -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
--   copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
--   copy_mode_inactive_highlight_bg = { Color = '#52ad70' },
--   copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },

--   quick_select_label_bg = { Color = 'peru' },
--   quick_select_label_fg = { Color = '#ffffff' },
--   quick_select_match_bg = { AnsiColor = 'Navy' },
--   quick_select_match_fg = { Color = '#ffffff' },
-- }
-- -----------------------------
-- and finally, return the configuration to wezterm
return config
