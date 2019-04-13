-- ========================================================================== --
-- example-03.lua
--
-- Similar to example-02, except now the header and footer regions decide
-- whether the device is in portrait or landscape. If in landscape, the header
-- puts itself on the left instead of the top, and the footer puts itself on the
-- right instead of the bottom.
-- layout.lua is in parent folder
-- NOTE: Corona to Gideros
-- package.path = "../?.lua;" .. package.path
-- local LayoutManager = require( "layout" )
-- layout manager object
local Layout

-- Group to hold rects that display the regions
local Regions

-- layout creation
local function createLayout()
    -- init the layout manager
    -- NOTE: Corona to Gideros
    -- Layout = LayoutManager:new()
    Layout = LayoutManager.new()

    -- device is in portrait orientation
    if (Layout.stage.isPortrait) then
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
        -- device is in landscape orientation
    else
        -- create a header occupying 10% of the stage
        Layout:addRegion({id = "header", horizontal = "left", width = 10})
        -- create a content area below the header with some small padding
        Layout:addRegion({
            id = "content",
            positionTo = "header",
            horizontal = "after",
            width = 83,
            padding = {left = 1}
        })
        -- create a footer area at the bottom of the stage
        Layout:addRegion({id = "footer", horizontal = "right", width = 5})
    end
end

-- ========================================================================== --

-- for demo purposes just display the layout regions as rects on the screen
local function showLayout()
    -- NOTE: Corona to Gideros
    -- Regions = display.newGroup()
    Regions = Sprite.new()
    stage:addChild(Regions)

    -- NOTE: Corona to Gideros
    -- showRegion( "header", {0.5,0,0} )
    -- showRegion( "content", {1,0.5} )
    -- showRegion( "footer", {0,0,0.5} )
    showRegion("header", {0.5, 0, 0}, Layout, Regions)
    showRegion("content", {1, 0.5}, Layout, Regions)
    showRegion("footer", {0, 0, 0.5}, Layout, Regions)
end

-- ========================================================================== --

-- orientation change listener
local function onOrientationChange(event)
    -- NOTE: Corona to Gideros
    -- Regions:removeSelf()
    Regions:removeFromParent()

    Regions = nil
    createLayout()
    showLayout()
end

-- add listener for orientation change
-- NOTE: Corona to Gideros
-- Runtime:addEventListener( "orientation", onOrientationChange )
stage:addEventListener(Event.APPLICATION_RESIZE, onOrientationChange)

-- ========================================================================== --

-- initial layout and display
createLayout()
showLayout()
