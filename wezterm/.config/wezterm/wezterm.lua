local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font('PragmataPro Mono Liga')
config.font_size = 18

config.color_scheme = 'Gruvbox (Gogh)'

return config
