
MOUSE_STATE = {}

function getMouseState()
    MOUSE_STATE.x = CURRENT_MOUSE_X
    MOUSE_STATE.y = CURRENT_MOUSE_Y
    MOUSE_STATE.is_clicked = 0

    if love.mouse.isDown(1) then
        MOUSE_STATE.is_clicked = 1
    end

    if love.mouse.isDown(2) then
        MOUSE_STATE.is_clicked = 2
    end

    if love.mouse.isDown(3) then
        MOUSE_STATE.is_clicked = 3
    end

    return MOUSE_STATE
end
    

function love.mousepressed(x, y, button)

    if button == 2 then
        for i = 1, #gates do
            if gates[i].collider:contains(x, y) then
                new_Gate(
                    gates[i].name, 
                    gates[i].bitboard, 
                    gates[i].color, 
                    gates[i].x, 
                    gates[i].y + gates[i].h + 10, 
                    gates[i].input_size, 
                    gates[i].output_size
                )
            end
        end
    end

    for i = 1, #INPUT_NODES do
        if INPUT_NODES[i].collider:contains(x, y) then
            INPUT_NODES[i].is_clicked = not INPUT_NODES[i].is_clicked
        end
    end

    


    for i = 1, #gates do

        local g = gates[i]:updateHighlights(x, y)

        if g then -- start new wire
            gates[i].lock = false
            ANCHOR_NODE_CURRENT = g
            break
        end

        if gates[i].collider:contains(x, y) then
            gates[i].tempColor = {1, 1, 0}
            gates[i].lock = true
            break
        end  
    end

end
    


function love.mousemoved(x, y, dx, dy)
    CURRENT_MOUSE_X = x
    CURRENT_MOUSE_Y = y
    CURRENT_MOUSE_DX = dx
    CURRENT_MOUSE_DY = dy

    for i = 1, #gates do
        if gates[i].collider:contains(x, y) then
            gates[i].tempColor = {0.7, 0.8, 0}
        else
            gates[i].tempColor = nil
        end

        local g = gates[i]:updateHighlights(x, y)

        if g then -- start new wire
            ANCHOR_NODE_HOVER = g
        end

        if gates[i].lock then
            gates[i]:update(dx, dy)
        end
    end
end


function love.mousereleased(x, y, button)

    for i = 1, #gates do
        gates[i].tempColor = nil
        gates[i].lock = false

        local g = gates[i]:updateHighlights(x, y)

        if g and ANCHOR_NODE_CURRENT then -- start new wire
            local wire_in_connection = ANCHOR_NODE_CURRENT
            local wire_out_connection = g

            local wire = new_Wire(wire_in_connection, wire_out_connection)
            GLOBAL_WIRE_BANK[#GLOBAL_WIRE_BANK + 1] = wire

            wire_in_connection:appendWire(wire)
            wire_out_connection:appendWire(wire)

        end
    end
    
    ANCHOR_NODE_CURRENT = false
    ANCHOR_NODE_HOVER = false
end