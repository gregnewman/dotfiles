-- Coding Layout dual monitors
local coding_layout_dual= {
  -- {"Emacs",             nil, main_monitor, hs.layout.maximized,     nil, nil},
  {"PyCharm",           nil, main_monitor, hs.layout.maximized,     nil, nil},
  {"Google Chrome",     nil, main_monitor, hs.layout.right50,       nil, nil},
  {"iTerm2",             nil, main_monitor, hs.layout.third_right,  nil, nil},
}

hs.hotkey.bind(hyper, '1', function()
  -- hs.application.launchOrFocus('Emacs')
  hs.application.launchOrFocus('PyCharm')
  hs.application.launchOrFocus('Google Chrome')
  hs.application.launchOrFocus('iTerm2')

  hs.layout.apply(coding_layout_dual)
end)

-- Productivity layout dual monitors
-- TODO: Add Drafts to this and throw in a second workspace
local productivity_layout_dual= {
  {"OmniFocus",     nil, main_monitor, hs.layout.right50,       nil, nil},
  {"Bear",          nil, main_monitor, hs.layout.left50,        nil, nil},
}

hs.hotkey.bind(hyper, '2', function()
  hs.application.launchOrFocus('OmniFocus')
  hs.application.launchOrFocus('Bear')

  hs.layout.apply(productivity_layout_dual)
end)