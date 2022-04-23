
function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    if key == "return" then
        
    end

    if key == "space" then
        
        if wire_in_progress then  
            wire_in_progress.value = (wire_in_progress.value + 1) % 2
        end

        if wire_in_hover then
            wire_in_hover.value = (wire_in_hover.value + 1) % 2
        end
        
    end

    if key == "backspace" then
        
        for i = 1, #GLOBAL_WIRE_BANK do
            GLOBAL_WIRE_BANK[i]:collision(CURRENT_MOUSE_X, CURRENT_MOUSE_Y)
        end

    end

end

