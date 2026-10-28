-- Apply Omarchy's Quake-style Scratchpad presentation to a special workspace.
return function(workspace_name, height_share)
  local share = height_share or 0.5
  local box = 2
  local beside, below = nil, nil

  local function cover(side, bottom)
    if beside == side and below == bottom then
      return false
    end

    beside, below = side, bottom
    hl.workspace_rule({
      workspace = workspace_name,
      gaps_in = 0,
      gaps_out = { top = 0, right = side, bottom = bottom, left = side },
      no_border = true,
    })

    return true
  end

  local function alone()
    local tiled = 0
    for _, window in ipairs(hl.get_workspace_windows(workspace_name)) do
      if not window.floating then
        tiled = tiled + 1
      end
    end
    return tiled <= 1
  end

  local function console_monitor()
    local workspace = hl.get_workspace(workspace_name)
    local monitor = workspace and workspace.visible and workspace.monitor

    if monitor and monitor.scale and monitor.scale > 0 then
      return monitor
    end

    return hl.get_active_monitor()
  end

  local function fit(monitor)
    if not monitor or not monitor.scale or monitor.scale <= 0 then
      return false
    end

    local width, height = monitor.width, monitor.height
    if monitor.transform % 2 == 1 then
      width, height = height, width
    end

    local reserved = monitor.reserved
    height = height / monitor.scale - reserved.top - reserved.bottom
    width = width / monitor.scale - reserved.left - reserved.right

    local tall = math.floor(height * share)
    local wide = alone() and math.min(width, tall * box) or width
    return cover(math.floor((width - wide) / 2), math.floor(height - tall))
  end

  local function refit(monitor)
    if fit(monitor or console_monitor()) then
      hl.exec_scheduled_prop_refresh_immediately()
    end
  end

  cover(0, 0)
  fit(console_monitor())

  hl.on("monitor.layout_changed", refit)
  hl.on("monitor.focused", refit)
  hl.on("workspace.special_active", function(workspace, monitor)
    if workspace and workspace.name == workspace_name then
      refit(monitor)
    end
  end)
  hl.on("workspace.move_to_monitor", function(workspace, monitor)
    if workspace and workspace.name == workspace_name then
      refit(monitor)
    end
  end)

  local function recount()
    local workspace = hl.get_workspace(workspace_name)
    if workspace and workspace.visible then
      refit()
    end
  end

  hl.on("window.open", recount)
  hl.on("window.destroy", recount)
  hl.on("window.move_to_workspace", recount)
  hl.on("window.update_rules", recount)

  -- Animation leaves are global to special workspaces, so use the same
  -- drop-down for every console set up through this module.
  hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide top" })
  hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 2, bezier = "easeInOutCubic", style = "slide bottom" })
end
