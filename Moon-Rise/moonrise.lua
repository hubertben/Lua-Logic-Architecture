
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
    button.lock_click = false

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


        button.is_highlighted = false
        ms = getMouseState()

        if ms.is_clicked == 0 then
            button.is_clicked = false

            button.lock_click = false
        end
    

        if CURRENT_MOUSE_X > button.x and CURRENT_MOUSE_X < button.x + button.w and CURRENT_MOUSE_Y > button.y and CURRENT_MOUSE_Y < button.y + button.h then
            
            button.is_highlighted = true
            
            if not button.lock_click and ms.is_clicked == 1 then
                button.is_clicked = true
                function_on_click()
                button.lock_click = true
            end
        end
        
    end

    return button
    
end


-- MOUSE_STATE = {}
-- function getMouseState()
--     MOUSE_STATE.x = CURRENT_MOUSE_X
--     MOUSE_STATE.y = CURRENT_MOUSE_Y
--     MOUSE_STATE.is_clicked = 0

--     if love.mouse.isDown(1) then
--         MOUSE_STATE.is_clicked = 1
--     end

--     if love.mouse.isDown(2) then
--         MOUSE_STATE.is_clicked = 2
--     end

--     if love.mouse.isDown(3) then
--         MOUSE_STATE.is_clicked = 3
--     end

--     return MOUSE_STATE
-- end
    
