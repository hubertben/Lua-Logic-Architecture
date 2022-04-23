function new_Wire(inputNode, outputNode)
    local wire = {}
    wire.value = 0

    print(inputNode.t .. " : " .. outputNode.t)
    
    -- if inputNode.t == "O" then
    --     wire.inputNode = outputNode
    --     wire.outputNode = inputNode
    -- else
        wire.inputNode = inputNode
        wire.outputNode = outputNode
    -- end


    


    
    

    wire.draw = function(self)

        if self.value ~= 0 then
            love.graphics.setColor(1, 0, 0)
        else
            love.graphics.setColor(0, 0, 0)
        end
        
        -- line width
        love.graphics.setLineWidth(3)

        local startx = self.inputNode.x
        local starty = self.inputNode.y
        local endx = self.outputNode.x
        local endy = self.outputNode.y

        wire.collider = WireCollisionBox(
            startx, starty, 
            ((startx + endx) / 2), starty, 
            ((startx + endx) / 2), endy, 
            endx, endy
        )

        love.graphics.line(startx, starty, ((startx + endx) / 2), starty)
        love.graphics.line(((startx + endx) / 2), starty, ((startx + endx) / 2), endy)
        love.graphics.line(((startx + endx) / 2), endy, endx, endy)
        
    end

    wire.updateConnection = function(self)
        if self.inputNode.value ~= self.outputNode.value then
            -- print(inputNode.value, outputNode.value)
            self.value = self.inputNode.value
            self.outputNode:propagate_value(self.value)
            -- print(inputNode.value, outputNode.value)
            -- print()
        end

    end

    wire.update = function(self, dx, dy)

        -- update value if input node is updated
        
        self.inputNode.x = self.inputNode.x + dx
        self.inputNode.y = self.inputNode.y + dy
        self.outputNode.x = self.outputNode.x + dx
        self.outputNode.y = self.outputNode.y + dy

        local startx = self.inputNode.x
        local starty = self.inputNode.y
        local endx = self.outputNode.x
        local endy = self.outputNode.y

        
        self.collider:update(
            startx, starty, 
            ((startx + endx) / 2), starty, 
            ((startx + endx) / 2), endy, 
            endx, endy
        )
    end

    wire.collision = function(self, x, y)
        print(x, y)
        if self.collider:contains(x, y) then
            print("collision")
            return true
        end
    end

    return wire
end