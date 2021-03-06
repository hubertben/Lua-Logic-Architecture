

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




function circuit_menu(x, y, w, h, color, items, parent)
    local menu = {}
    menu.x = x
    menu.y = y
    menu.w = w
    menu.h = h
    menu.color = color
    menu.items = items
    menu.parent = parent
    menu.visible = true

    menu.init = function(self)
        menu.buttons = {}
        local part = seperate(x, y, w, h, 1, #menu.items)
        displayTable(part)

        local max_font_size = 1000

        local buffer = 2

        for i = 1, #menu.items do
            local size = (part[1][i].w/buffer)
            if getMaxFontSize(menu.items[i], size) < max_font_size then
                max_font_size = getMaxFontSize(menu.items[i], size)
            end
        end

        for i = 1, #menu.items do


            local button = newButton(
                part[1][i].x, 
                part[1][i].y,
                part[1][i].w,
                part[1][i].h,
                {0.5, 0.5, 0.5}, 
                {0.7, 0.7, 0.7}, 
                {1, 1, 1}, 
                menu.items[i], 
                max_font_size,
                -- new_gate_from_primitive(menu.items[i], x, y)
                function()
                    new_gate_from_primitive(menu.items[i], part[1][i].x + 20, HEIGHT - 100 - part[1][i].h - 10)
                end
            )
            table.insert(menu.buttons, button)
        end
    end

    menu.append_item = function(self, item)
        table.insert(self.items, item)
        self:init()
    end

    menu.update = function(self)
        for i = 1, #self.buttons do
            self.buttons[i]:update()
        end
    end

    menu.draw = function()
        if menu.visible then
            love.graphics.setColor(menu.color)
            love.graphics.rectangle("fill", menu.x, menu.y, menu.w, menu.h)
            love.graphics.setColor(1, 1, 1)
            love.graphics.rectangle("line", menu.x, menu.y, menu.x, menu.h)
            love.graphics.setColor(1, 1, 1)
            
            for i = 1, #menu.buttons do
                menu.buttons[i].draw()
            end
            
            
        end
    end

    return menu
end