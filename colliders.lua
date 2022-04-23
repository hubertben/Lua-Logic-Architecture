
function CircleCollisionBox(x, y, r)
    return {
        x = x,
        y = y,
        r = r,
        contains = function(self, x, y)
            return (x - self.x)^2 + (y - self.y)^2 <= self.r^2
        end,
        update = function(self, x, y)
            self.x = x
            self.y = y
        end
    }
end

function RectangleCollisionBox(x, y, w, h)
    return {
        x = x,
        y = y,
        w = w,
        h = h,
        contains = function(self, x, y)
            return x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h
        end,
        update = function(self, x, y)
            self.x = x
            self.y = y
        end
    }
end

function WireCollisionBox(x1, y1, x2, y2, x3, y3, x4, y4)
    return {
        x1 = x1,
        y1 = y1,
        x2 = x2,
        y2 = y2,
        x3 = x3,
        y3 = y3,
        x4 = x4,
        y4 = y4,
        
        contains = function(self, x, y)
            
            -- return true is x, y is within 10 pixels of each line (x1, y1) to (x2, y2), (x2, y2) to (x3, y3), (x3, y3) to (x4, y4)
            return (x >= self.x1 - 10 and x <= self.x1 + 10 and y >= self.y1 - 10 and y <= self.y1 + 10) or
                   (x >= self.x2 - 10 and x <= self.x2 + 10 and y >= self.y2 - 10 and y <= self.y2 + 10) or
                   (x >= self.x3 - 10 and x <= self.x3 + 10 and y >= self.y3 - 10 and y <= self.y3 + 10) or
                   (x >= self.x4 - 10 and x <= self.x4 + 10 and y >= self.y4 - 10 and y <= self.y4 + 10)

        end,
        update = function(self, x1, y1, x2, y2, x3, y3, x4, y4)
            self.x1 = x1
            self.y1 = y1
            self.x2 = x2
            self.y2 = y2
            self.x3 = x3
            self.y3 = y3
            self.x4 = x4
            self.y4 = y4
        end
    }
end