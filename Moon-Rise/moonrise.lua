
require "Moon-Rise.toolbox"

function generateImageFromPath(path)
    local image = love.graphics.newImage(path)
    return image
end

function coordsFromCenter(x, y, w, h)
    return {x - w / 2, y - h / 2}
end

function drawImageCentered(x, y, w, h, img)
    local x, y = coordsFromCenter(x, y, w, h)
    love.graphics.draw(img, x, y, 0, w / img:getWidth(), h / img:getHeight())
end


function seperate(startx, starty, endx, endy, rows, cols)

    local row_partition_size = (endy - starty) / rows
    local col_partition_size = (endx - startx) / cols

    local row_partitions = {}

    for i = 1, rows do
        row_partitions[i] = {}
        for j = 1, cols do
            row_partitions[i][j] = {
                x = startx + (j - 1) * col_partition_size,
                y = starty + (i - 1) * row_partition_size,
                w = col_partition_size,
                h = row_partition_size
            }
        end
    end

    return row_partitions
end
    

function scaleToFit(max_w, max_h, image_cur_width, image_cur_height)
    local scale_x = max_w / image_cur_width
    local scale_y = max_h / image_cur_height

    local scale = math.min(scale_x, scale_y)
    return scale
end


function drawImageArray(x, y, max_w, max_h, row_count, col_count, paths)

    if #paths == 0 then
        return
    end

    if #paths < row_count * col_count then
        return false
    end

    local image_cur_width = paths[1]:getWidth()
    local image_cur_height = paths[1]:getHeight()

    local partitions = seperate(x, y, max_w, max_h, row_count, col_count)
    local count = 1
    for i = 1, row_count do
        for j = 1, col_count do
            local partition = partitions[i][j]
            local scale = scaleToFit(partition.w, partition.h, image_cur_width, image_cur_height)
            local img = paths[count]
            love.graphics.draw(img, partition.x, partition.y, 0, scale, scale)
            count = count + 1
        end
    end
    
end

    



function newButton(x, y, w, h, color, highlight_color, outline, internal_text, text_size, function_on_click)

    local button = {}
    button.x = x
    button.y = y
    button.w = w
    button.h = h
    button.color = color
    button.highlight_color = highlight_color
    button.outline = outline
    button.internal_text = internal_text
    button.text_size = text_size
    button.function_on_click = function_on_click

    button.is_clicked = false
    button.is_highlighted = false

    button.draw = function()
        if button.is_highlighted then
            love.graphics.setColor(button.highlight_color)
        else
            love.graphics.setColor(button.color)
        end
        love.graphics.rectangle("fill", button.x, button.y, button.w, button.h)
        love.graphics.setColor(button.outline)
        love.graphics.rectangle("line", button.x, button.y, button.w, button.h)
        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(love.graphics.newFont(button.text_size))
        love.graphics.print(button.internal_text, button.x + button.w / 2 - love.graphics.getFont():getWidth(button.internal_text) / 2, button.y + button.h / 2 - love.graphics.getFont():getHeight(button.internal_text) / 2)
    end

    button.update = function(dt)

        local mouse_x, mouse_y = love.mouse.getPosition()

        button.is_highlighted = false

        if mouse_x > button.x and mouse_x < button.x + button.w and mouse_y > button.y and mouse_y < button.y + button.h then
            button.is_highlighted = true
            
        end
        
        if button.is_clicked then
            function_on_click()
            button.is_clicked = false
        end
    end

    return button
    
end


function getMouseState()
    local mouse_x, mouse_y = love.mouse.getPosition()
    local mouse_state = {}
    mouse_state.x = mouse_x
    mouse_state.y = mouse_y
    mouse_state.is_clicked = love.mouse.isDown(1)
    return mouse_state
end
    
