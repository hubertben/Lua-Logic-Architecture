

CURRENTLY_TYPING = false
CURRENT_WORD = "_"

function love.keypressed(key)

    if key == "tab" then -- op code for starting a new word
        CURRENTLY_TYPING = not CURRENTLY_TYPING 
    end

    if CURRENTLY_TYPING then
        letterTyped(key)
    end

    if key == "escape" then
        love.event.quit()
    end

    if key == "return" then

        if CURRENT_WORD ~= "_" then
           
        


            CIRCUIT_MENU:append_item(string.sub(CURRENT_WORD, 1, #CURRENT_WORD - 1))
        end 
    end

    if key == "space" then
        
        if ANCHOR_NODE_CURRENT then  
            ANCHOR_NODE_CURRENT.value = (ANCHOR_NODE_CURRENT.value + 1) % 2
        end

        if ANCHOR_NODE_HOVER then
            ANCHOR_NODE_HOVER.value = (ANCHOR_NODE_HOVER.value + 1) % 2
        end
        
    end

    if key == "backspace" then
        
        for i = 1, #GLOBAL_WIRE_BANK do
            GLOBAL_WIRE_BANK[i]:collision(CURRENT_MOUSE_X, CURRENT_MOUSE_Y)
        end

    end
end

valid_letters = {
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
}


function letterTyped(key)

    if #CURRENT_WORD > 1 then
        if key == "backspace" then
            CURRENT_WORD = string.sub(CURRENT_WORD, 1, #CURRENT_WORD - 2)
            CURRENT_WORD = CURRENT_WORD .. "_"
        end
    end

    

    if key == "space" then
        CURRENT_WORD = string.sub(CURRENT_WORD, 1, #CURRENT_WORD - 1)
        CURRENT_WORD = CURRENT_WORD .. " " .. "_"
    end
    
    
    for _, v in pairs(valid_letters) do
        if key == v then
            CURRENT_WORD = string.sub(CURRENT_WORD, 1, #CURRENT_WORD - 1)
            CURRENT_WORD = CURRENT_WORD .. string.upper(key) .. "_"
        end
    end
end
    


