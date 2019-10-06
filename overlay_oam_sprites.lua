local OAMOffset = 0xFE00
local LCDCRegisterOffset = 0xFF40
local FirstLoop = true
local enableOutput = false

--- Draw a sprite overlay with slot number
function drawSpriteLocation(x, y, spriteNumber, color, spriteHeight)
    if (x > 0 and y > 0 and x < 168 and y < 160) then
        gui.drawText(x - 10, y - 16, spriteNumber, "red", 0x00000000, 8, nil, nil, "left", "top")
        gui.drawRectangle(x - 8, y - 16, 7, spriteHeight - 1, 0x550000FF, 0x550000FF)
        -- gui.drawPixel(x-8, y-16, "red")
        -- gui.drawPixel(x-1, y - 16, "green")
    end
end

--- Get OAM Attributes for a sprite slot by index
--- Reads 4 bytes from 0xFE00 + 4 * sprite slot
function getOAMAttrs(slot) 
    if (slot < 40 and slot >= 0) then
        local spriteOffset = OAMOffset + (slot * 4)
        local spriteY = memory.readbyte(spriteOffset)
        local spriteX = memory.readbyte(spriteOffset + 1)
        local spriteTile = memory.readbyte(spriteOffset + 2)
        local spriteFlags = memory.readbyte(spriteOffset + 3)
        if (enableOutput = true and FirstLoop == true) then
            print("00:"..string.format("%x",spriteOffset)    .." OBJ"..slot.."_Y    ; OBJ"..slot.." LCD y- coordinate")
            print("00:"..string.format("%x",spriteOffset + 1).." OBJ"..slot.."_X    ; OBJ"..slot.." LCD x- coordinate")
            print("00:"..string.format("%x",spriteOffset + 2).." OBJ"..slot.."_CC   ; OBJ"..slot.." Character code")
            print("00:"..string.format("%x",spriteOffset + 3).." OBJ"..slot.."_ATTR ; OBJ"..slot.." Attribute flag")    
        end
        return spriteY, spriteX, spriteTile, spriteFlags
    end
end

--- Draw an overlay on all of the 40 sprites stored in OAM
function drawOAMSprites(spriteHeight)
    local color = 0x550000FF
    for i = 0, 39 do
        local y, x, tile, flags = getOAMAttrs(i)
        drawSpriteLocation(x, y, i, color, spriteHeight)
    end
    FirstLoop = false
end


--- Check the LCD Control register to see what the sprite height is set to.
--- Sprites are always 8x8 or 8x16.
--- $FF40 - 1 byte
function getLCDCSpriteHeight()
    local lcdcRegVal = memory.readbyte(LCDCRegisterOffset)
    -- print(bizstring.binary(lcdcRegVal))
    if (bit.check(lcdcRegVal, 2)) then
        return 16
    end
    return 8
end

while true do
    local spriteHeight = getLCDCSpriteHeight()
    drawOAMSprites(spriteHeight)
    emu.frameadvance()
end
