

function new_Menu(x, y, w, h, color, items, parent)
    local menu = {}
    menu.x = x
    menu.y = y
    menu.w = w
    menu.h = h
    menu.color = color
    menu.items = items
    menu.parent = parent
    menu.visible = false
end