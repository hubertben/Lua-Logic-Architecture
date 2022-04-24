
require "Moon-Rise.toolbox"
require "Moon-Rise.moonrise"
require "gate"
require "bitboard"
require "colliders"
require "wire"
require "node"
require "mouseHandler"
require "keyboardHandler"
require "menu"



WIDTH = love.graphics.getWidth()
HEIGHT = love.graphics.getHeight()

GLOBAL_WIRE_BANK = {}
INPUT_NODES = {}
OUTPUT_NODES = {}

gates = {}
STORED_GATES = {}

CIRCUIT_MENU = nil -- circuit_menu(0, HEIGHT - 100, WIDTH, HEIGHT, {0, 0, 0}, {"AND", "OR", "NOT", "XOR", "HALF ADDER"}, nil)



function love.load()

    INPUT_NODES[#INPUT_NODES + 1] = new_IO_node(100, 300, 20, "I")
    INPUT_NODES[#INPUT_NODES + 1] = new_IO_node(100, 400, 20, "I")
    INPUT_NODES[#INPUT_NODES + 1] = new_IO_node(100, 500, 20, "I")

    OUTPUT_NODES[#OUTPUT_NODES + 1] = new_IO_node(WIDTH - 100, 350, 20, "O")
    OUTPUT_NODES[#OUTPUT_NODES + 1] = new_IO_node(WIDTH - 100, 450, 20, "O")

    
    
    new_Gate(
        "AND", 
        new_Bitboard({{0, 0}, {0, 1}, {1, 0}, {1, 1}}, {{0}, {0}, {0}, {1}}), 
        {50, 255, 230}, 
        100, 
        100, 
        2,  
        1
    )

    new_Gate(
        "OR", 
        new_Bitboard({{0, 0}, {0, 1}, {1, 0}, {1, 1}}, {{0}, {1}, {1}, {1}}), 
        {250, 40, 230}, 
        500, 
        100, 
        2, 
        1
    )

    new_Gate(
        "NOT", 
        new_Bitboard({{0}, {1}}, {{1}, {0}}), 
        {250, 140, 130}, 
        500, 
        300, 
        1, 
        1
    )

    new_Gate(
        "XOR", 
        new_Bitboard({{0, 0}, {0, 1}, {1, 0}, {1, 1}}, {{0}, {1}, {1}, {0}}), 
        {50, 240, 130}, 
        100, 
        300, 
        2, 
        1
    )

    CIRCUIT_MENU = circuit_menu(0, HEIGHT - 100, WIDTH, HEIGHT, {0, 0, 0}, {"AND", "OR", "NOT", "XOR"}, nil)
    CIRCUIT_MENU:init()

end

function love.update(dt)

    for i = 1, #gates do
        gates[i]:bitboard_update()
    end

    for i = 1, #GLOBAL_WIRE_BANK do
        GLOBAL_WIRE_BANK[i]:updateConnection()
    end

    CIRCUIT_MENU:update()
    

end


ANCHOR_NODE_CURRENT = false
ANCHOR_NODE_HOVER = false

CURRENT_MOUSE_X = 0
CURRENT_MOUSE_Y = 0

CURRENT_MOUSE_DX = 0
CURRENT_MOUSE_DY = 0

function love.draw()
    love.graphics.setBackgroundColor( rgb( 50, 50, 50 ) )

    if CURRENTLY_TYPING then
        local font1 = love.graphics.newFont(30)
        love.graphics.setFont(font1)
        love.graphics.print("Construct Mode: " .. CURRENT_WORD, 10, 10)
    else
        local font1 = love.graphics.newFont(30)
        love.graphics.setFont(font1)
        love.graphics.print("Circuit Mode", 10, 10)
    end

    CIRCUIT_MENU:draw()

    for i = 1, #GLOBAL_WIRE_BANK do
        GLOBAL_WIRE_BANK[i]:draw()
    end

    for i = 1, #INPUT_NODES do
        INPUT_NODES[i]:draw()
    end

    for i = 1, #OUTPUT_NODES do
        OUTPUT_NODES[i]:draw()
    end

    for i = 1, #gates do
        gates[i]:draw()
    end

    

    if ANCHOR_NODE_CURRENT then
        love.graphics.setLineWidth(3)
        drawCurrentWire(ANCHOR_NODE_CURRENT.x, ANCHOR_NODE_CURRENT.y, CURRENT_MOUSE_X, CURRENT_MOUSE_Y, ANCHOR_NODE_CURRENT.value)
    end
    
end

function drawCurrentWire(startx, starty, mousex, mousey, value)
    
    if value ~= 0 then
        love.graphics.setColor(rgb(255, 0, 0))
    else
        love.graphics.setColor(rgb(0, 0, 0))
    end
    
    love.graphics.line(startx, starty, ((startx + mousex) / 2), starty)
    love.graphics.line(((startx + mousex) / 2), starty, ((startx + mousex) / 2), mousey)
    love.graphics.line(((startx + mousex) / 2), mousey, mousex, mousey)

end
    