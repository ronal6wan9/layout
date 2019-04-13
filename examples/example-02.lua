-- ========================================================================== --
-- example-02.lua
--
-- Identical to example-01, except the regions now adjust if the device
-- orientation changes.
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
end

-- ========================================================================== --

-- for demo purposes just display the layout regions as rects on the screen
local function showLayout()
    -- NOTE: Corona to Gideros
    -- Regions = display.newGroup()
    Regions = Sprite.new()
    stage:addChild(Regions)

    -- NOTE: Corona to Gideros
    -- showRegion( "header", {0.5, 0, 0} )
    -- showRegion( "content", {1, 0.5} )
    -- showRegion( "footer", {0, 0, 0.5} )
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
