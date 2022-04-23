

function new_Gate(name, bitboard, color, x, y, input_size, output_size)
    local gate = {}
    gate.name = name
    gate.bitboard = bitboard
    gate.color = rgb(color[1], color[2], color[3])
    gate.x = x
    gate.y = y

    gate.lock = false

    gate.connections = {}
   
    gate.input_size = input_size
    gate.output_size = output_size

    local scale = 40

    gate.w = (#name * scale) + (150 / #name)
    gate.h = math.max(gate.input_size, gate.output_size) * scale

    gate.collider = RectangleCollisionBox(x, y, gate.w, gate.h)

    gate.tempColor = nil

    gate.draw = function(self)
        
        if self.tempColor then
            love.graphics.setColor(self.tempColor)
        else
            love.graphics.setColor(self.color)
        end

        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
        love.graphics.setColor(0, 0, 0)
        local font1 = love.graphics.newFont(scale)
        love.graphics.setFont(font1)
        love.graphics.print(self.name, self.x + self.w / 2 - love.graphics.getFont():getWidth(self.name) / 2, self.y + self.h / 2 - love.graphics.getFont():getHeight() / 2)
        gate.drawNodes(self)
    end

    gate.nodes = {
        inputs = {},
        outputs = {}
    }

    gate.init_nodes = function(self)

        local space_I = self.h / (self.input_size + 1)
        local space_O = self.h / (self.output_size + 1)

        local id = 1
        for i = 1, tonumber(self.input_size) do
            local n = new_Node(self.x, self.y + ((space_I * i)), scale / 3.4, self, id, "I")
            table.insert(self.nodes.inputs, n)
            id = id + 1
        end

        for i = 1, tonumber(self.output_size) do
            local n = new_Node(self.x + self.w, self.y + ((space_O * i)), scale / 3.4, self, id, "O")
            table.insert(self.nodes.outputs, n)
            id = id + 1
        end
    end

    gate.drawNodes = function(self)
        for i = 1, #self.nodes.inputs do
            self.nodes.inputs[i]:draw()
        end

        for i = 1, #self.nodes.outputs do
            self.nodes.outputs[i]:draw()
        end
    end

    gate.updateNodes = function(self, dx, dy)

        for i = 1, #self.nodes.inputs do    
            self.nodes.inputs[i]:update(dx, dy)
        end
        for i = 1, #self.nodes.outputs do
            self.nodes.outputs[i]:update(dx, dy)
        end
    end


    gate.updateHighlights = function(self, x, y)
       
        for i = 1, #self.nodes.inputs do
            if self.nodes.inputs[i].collider:contains(x, y) then
                self.nodes.inputs[i].highlighted = true
                return self.nodes.inputs[i]
            else
                self.nodes.inputs[i].highlighted = false
            end
        end

        for i = 1, #self.nodes.outputs do
            if self.nodes.outputs[i].collider:contains(x, y) then
                self.nodes.outputs[i].highlighted = true
                return self.nodes.outputs[i]
            else
                self.nodes.outputs[i].highlighted = false
            end
        end

        return false
    end

   

   

    gate.collision = function(self, x, y)
        for i = 1, #self.connections do
            if self.connections[i].collider:collision(x, y) then
                return true
            end
        end

        if self.collider:collision(x, y) then
            return true
        end

    end


    gate.bitboard_update = function(self)
        -- collect values from inputs and store in a table
        local inputs = {}
        for i = 1, #self.nodes.inputs do
            inputs[i] = self.nodes.inputs[i].value
        end

        local eval = self.bitboard:evaluate(inputs)

        for i = 1, #self.nodes.outputs do
            self.nodes.outputs[i].value = eval[i]
        end
    end

    gate.update = function(self, dx, dy)

        self.x = self.x + dx
        self.y = self.y + dy

        self.collider:update(self.x, self.y)
        gate:updateNodes(dx, dy)
    end
        

    gate.init_nodes(gate)

    gates[#gates + 1] = gate
    return gate
end




function new_gate_from_primitive(name, x, y)

    -- search gates for matching name
    local prim = nil
    for i = 1, #gates do
        if gates[i].name == name then
            prim = gates[i]
            break
        end
    end

    if not prim then
        print("ERROR: gate not found")
        return
    end


    new_Gate(
        name,
        prim.bitboard,
        prim.color,
        x,
        y,
        prim.input_size,
        prim.output_size
    )

    
end