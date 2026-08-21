# Zathura theme configuration
# Generated based on the user's preferred color palette

# Recoloring (PDF recolor mode)
set recolor                     "true"
set recolor-lightcolor          "{{ background }}"
set recolor-darkcolor           "{{ foreground }}"
set recolor-keephue             "true"

# Basic colors
set default-bg                  "#1a1a1a"
set default-fg                  "{{ foreground }}"

# Completion UI
set completion-bg               "{{ muted }}"
set completion-fg               "{{ foreground }}"
set completion-group-bg         "{{ color0 }}"
set completion-group-fg         "{{ muted }}"
set completion-highlight-bg     "{{ bright_blue }}"
set completion-highlight-fg     "{{ muted }}"

# Index view
set index-bg                    "{{ muted }}"
set index-fg                    "{{ foreground }}"
set index-active-bg             "{{ bright_blue }}"
set index-active-fg             "{{ muted }}"

# Input bar
set inputbar-bg                 "{{ color0 }}"
set inputbar-fg                 "{{ foreground }}"

# Status bar
set statusbar-bg                "{{ muted }}"
set statusbar-fg                "{{ foreground }}"

# Highlights
# Using '80' for ~0.5 alpha transparency
set highlight-color             "{{ bright_yellow }}80"
set highlight-active-color      "{{ accent }}80"

# Notifications
set notification-bg             "{{ color0 }}"
set notification-fg             "{{ bright_green }}"
set notification-error-bg       "{{ color0 }}"
set notification-error-fg       "{{ bright_red }}"
set notification-warning-bg     "{{ color0 }}"
set notification-warning-fg     "{{ bright_yellow }}"

# Loading screen
set render-loading              "true"
set render-loading-bg           "#1a1a1a"
set render-loading-fg           "{{ foreground }}"
