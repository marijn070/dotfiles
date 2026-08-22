-- Planify Tasks
hl.unbind("SUPER + P")
hl.unbind("SUPER + SHIFT + P")
o.bind("SUPER + P", "Add Task", { launch = "planify.quick-add" })
o.bind("SUPER + SHIFT + P", "Planify", { launch = "planify" })
