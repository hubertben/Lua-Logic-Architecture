
function new_Node(x, y, r, parent, id, t)
    local node = {

        value = 0,

        id = id,

        x = x,
        y = y,
        r = r,

        t = t, -- type, "I" or "O"

        wires = {},
        current_num_wires = 0,

        parent = parent,
        highlighted = false,
        collider = CircleCollisionBox(x, y, r),
        
        draw = function(self)
            
            -- print(self.id .. ": " .. self.parent.name .. ": VALUE: " .. self.value .. ": " .. self.value == 1)

            if self.value ~= 0 then
                love.graphics.setColor(1, 0, 0)
            else
                love.graphics.setColor(0, 0, 0)
            end
            
            
            if self.highlighted then
                love.graphics.circle("fill", self.x, self.y, self.r * 1.5)
            else    
                love.graphics.circle("fill", self.x, self.y, self.r)
            end

            -- draw wires

        end,

        update = function(self, dx, dy)
            self.x = self.x + dx
            self.y = self.y + dy
            self.collider:update(self.x, self.y)

            for i = 1, #self.wires do
                self.wires[i]:update(0, 0)
            end
        end,

        appendWire = function (self, wire, giver)
            self.wires[#self.wires + 1] = wire
            self.current_num_wires = self.current_num_wires + 1
        end,

        propagate_value = function(self, value)
            self.value = value
            for i = 1, #self.wires do
                self.wires[i].value = value
            end
        end,

    }
    return node
end




function new_IO_node(x, y, r)

    local node = {

        value = 0,

        x = x,
        y = y,
        r = r,
        wires = {},
        current_num_wires = 0,

        draw = function(self)
            
            -- print(self.id .. ": " .. self.parent.name .. ": VALUE: " .. self.value .. ": " .. self.value == 1)

            if self.value ~= 0 then
                love.graphics.setColor(1, 0, 0)
            else
                love.graphics.setColor(0, 0, 0)
            end
            
            
            if self.highlighted then
                love.graphics.circle("fill", self.x, self.y, self.r * 1.5)
            else    
                love.graphics.circle("fill", self.x, self.y, self.r)
            end

            -- draw wires

        end,

        update = function(self, dx, dy)
            self.x = self.x + dx
            self.y = self.y + dy
            self.collider:update(self.x, self.y)

            for i = 1, #self.wires do
                self.wires[i]:update(0, 0)
            end
        end,

        appendWire = function (self, wire, giver)
            self.wires[#self.wires + 1] = wire
            self.current_num_wires = self.current_num_wires + 1
        end,

        propagate_value = function(self, value)
            self.value = value
            for i = 1, #self.wires do
                self.wires[i].value = value
            end
        end,

    }
    return node
end
    


