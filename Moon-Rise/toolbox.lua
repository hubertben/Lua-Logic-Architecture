function readSave()

    local file = love.filesystem.newFile("save.txt")
    file:open("r")
    local save = {}
    for line in file:lines() do
        local key, value = line:match("(.+):(.+)")
        save[key] = value 
    end
    file:close()
    return save
end

function writeSaves(saves)
    local file = love.filesystem.newFile("saves.txt")
    file:open("w")
    file:write(saves)
    file:close()
end

function map(x, a, b, c, d)
    return (x - a) * (d - c) / (b - a) + c
end

function rgb(r, g, b)
    if(r <= 1 and g <= 1 and b <= 1) then
        return {r, g, b}
    else
        return {r / 255, g / 255, b / 255}
    end
end

function dec2bin(dec)
    local bin = ""

    if dec == 0 then
        return "0"
    end

    while dec > 0 do
        bin = tostring(dec % 2) .. bin
        dec = math.floor(dec / 2)
    end
    return bin
end

function bin2dec(bin)
    return tonumber(bin, 2)
end

function displayTable(t, tab)

    if(tab == nil) then
        tab = 0
    end

    for k, v in pairs(t) do

        local print_tab = ""
        for i = 1, tab do
            print_tab = print_tab .. " - "
        end
        
        if type(v) == "table" then

            print(print_tab .. k .. ": ")
            displayTable(v, tab + 1)

        elseif type(v) == "function" then

            print(print_tab .. k .. ": Function")
        else
            print(print_tab .. k .. ": " .. v)
            
        end
    end
end


function checkNull(x)
    if x == nil then
        return false
    else
        return true
    end
end
    


function getMaxFontSize(str, width)
    local teststring = str
    local fontsize = 10
    local testFont = love.graphics.newFont(fontsize)
    local textWidth = testFont:getWidth(teststring)
    while textWidth < width do
        fontsize = fontsize + 5
        testFont = love.graphics.newFont(fontsize)
        textWidth = testFont:getWidth(teststring)
    end
    return fontsize
end