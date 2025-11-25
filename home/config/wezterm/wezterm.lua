-- Import the wezterm module
local wezterm = require 'wezterm'
-- ressurct plugin
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
-- Creates a config object which we will be adding our config to
local config = wezterm.config_builder()

-- Core Config
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.audible_bell = "Disabled"
config.tab_max_width = 200

-- How many lines of scrollback you want to retain per tab
config.scrollback_lines = 50000

-- Theme
-- Find them here: https://wezfurlong.org/wezterm/colorschemes/index.html
config.color_scheme = 'Dracula (Official)'
-- config.color_scheme = 'Solarized'
config.window_background_opacity = 0.5
config.macos_window_background_blur = 30
config.inactive_pane_hsb = {
  saturation = 0.5,
  brightness = 0.6,
}
config.command_palette_rows = 10
config.show_new_tab_button_in_tab_bar = false
config.colors = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = '#000000',
  }
}
config.window_padding = {
  left = '8',
  right = '8',
  top = '0cell',
  bottom = '0cell',
}
config.window_frame = {
  inactive_titlebar_bg = '#353535',
  active_titlebar_bg = '#2b2042',
  inactive_titlebar_fg = '#cccccc',
  active_titlebar_fg = '#ffffff',
  inactive_titlebar_border_bottom = '#353535',
  active_titlebar_border_bottom = '#353535',
  button_fg = '#cccccc',
  button_bg = '#353535',
  button_hover_fg = '#ffffff',
  button_hover_bg = '#3b3052',
  border_left_width = '0.25cell',
  border_right_width = '0.25cell',
  border_bottom_height = '0.25cell',
  border_top_height = '0.25cell',
  border_left_color = '#353535',
  border_right_color = '#353535',
  border_bottom_color = '#353535',
  border_top_color = '#353535',
}

-- Fonts
config.font = wezterm.font({ family = 'Fira Code' })
-- And a font size that won't have you squinting
config.font_size = 13

-- Powerline
local function segments_for_right_status(window)
  return {
    window:active_workspace(),
    wezterm.strftime('%a %b %-d %H:%M'),
    wezterm.hostname():match("([^.]+)"),
  }
end

wezterm.on('update-status', function(window, _)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  local segments = segments_for_right_status(window)

  local color_scheme = window:effective_config().resolved_palette
  -- Note the use of wezterm.color.parse here, this returns
  -- a Color object, which comes with functionality for lightening
  -- or darkening the colour (amongst other things).
  local bg = wezterm.color.parse(color_scheme.background)
  local fg = color_scheme.foreground

  -- Each powerline segment is going to be coloured progressively
  -- darker/lighter depending on whether we're on a dark/light colour
  -- scheme. Let's establish the "from" and "to" bounds of our gradient.
  local gradient_to, gradient_from = bg
  gradient_from = gradient_to:lighten(0.2)


  -- Yes, WezTerm supports creating gradients, because why not?! Although
  -- they'd usually be used for setting high fidelity gradients on your terminal's
  -- background, we'll use them here to give us a sample of the powerline segment
  -- colours we need.
  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments -- only gives us as many colours as we have segments.
  )

  -- We'll build up the elements to send to wezterm.format in this table.
  local elements = {}

  for i, seg in ipairs(segments) do
    local is_first = i == 1

    if is_first then
      table.insert(elements, { Background = { Color = 'none' } })
    end
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })

    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  window:set_right_status(wezterm.format(elements))
end)

-- Enable periodic saving (saves every 15 minutes by default)
resurrect.state_manager.periodic_save()

-- Auto-restore on startup
wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)

-- Add keybindings for save/load
config.keys = {
  -- Save current session
  {
    key = 'S',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      resurrect.save_state(resurrect.workspace_state.get_workspace_state())
    end),
  },
  -- Load/restore session
  {
    key = 'R',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      resurrect.fuzzy_load(window, pane, function(id)
        resurrect.workspace_state.restore_workspace(resurrect.load_state(id, "workspace"), {
          window = window,
          relative = true,
          restore_text = true,
        })
      end)
    end),
  },
}

-- Returns our config to be evaluated. We must always do this at the bottom of this file
return config
