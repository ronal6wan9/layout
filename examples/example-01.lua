-- ========================================================================== --
-- example-01.lua
--
-- Portrait only, create three fixed regions, a header that is 10% of the
-- vertical display, a footer that is 5% of the vertical display, and then a
-- content area in between that is padded above and below by 1% of the vertical
-- display (thus the content area is 83% of the vertical stage).
-- layout.lua is in parent folder
-- package.path = "../?.lua;" .. package.path
-- local LayoutManager = require( "layout" )
-- init a new layout manager
-- NOTE: Corona to Gideros
-- local Layout = LayoutManager:new()
local Layout = LayoutManager.new()

-- create a header occupying 10% of the stage
Layout:addRegion({id = "header", vertical = "top", height = 10})

-- create a content area below the header with some small padding
Layout:addRegion({
    id = "content",
    positionTo = "header",
    vertical = "below",
    height = 83,
    padding = {top = 1}
})

-- create a footer area at the bottom of the stage
Layout:addRegion({id = "footer", vertical = "bottom", height = 5})

-- ========================================================================== --

-- helper function to display a region as a rect
local function showRegion(id, fill)
    local rect = Layout:regionRect(id)

    -- NOTE: Corona to Gideros
    -- rect.fill = fill or { 0, 0 }
    -- rect.stroke = { 1, 1 }
    -- rect.strokeWidth = Layout.pixel
    fill = fill or {0, 0}
    if #fill == 3 then fill = {rgb(fill[1], fill[2], fill[3])} end
    rect:setFillColor(unpack(fill))
    rect:setLineColor(0xffffff)
    rect:setLineThickness(1)

    local region = Layout[id]

    -- NOTE: Corona to Gideros
    -- local text = display.newText( id, region.xCenter, region.yCenter, native.systemFont, 20 * Layout.pixel )
    -- text.fill = { 1, 1 }
    local text = TextField.new(
        nil,
        id,
        id,
        {
            w = region.width,
            h = region.height,
            flags = FontBase.TLF_CENTER | FontBase.TLF_VCENTER
        }
    )
    text:setPosition(region.xCenter, region.yCenter)
    text:setTextColor(0xffffff)
end

-- for demo purposes just display the layout regions as rects on the screen
showRegion("header", {0.5, 0, 0})
showRegion("content", {1, 0.5})
showRegion("footer", {0, 0, 0.5})
