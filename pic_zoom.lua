local composer = require( "composer" )
local gameState = require("gamestate")

local scene = composer.newScene()
local widget = require( "widget" )
local reload=false
local menu =false
local  category  = gameState.category
local level = gameState.level


function  scene:create(event)
	local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent



local background = display.newImage( sceneGroup,"bg_transc.png")
--background:scale( 0.75, 0.75)
background.x=display.contentCenterX
background.y=display.contentCenterY


  local show_img = display.newImageRect(sceneGroup,"puzz"..category..level..".jpg", 300, 300 )
  show_img.x=display.contentCenterX
  show_img.y=display.contentCenterY

local close =widget.newButton(
    {
        width = 44,
        height = 45,
        defaultFile = "x_bt.png",
        --overFile = "x_icon.png",
        --label = "bt_reload",
        onEvent = function ( )
         -- unlock=false
          composer.hideOverlay( "fade", 400 )   

        end

  }

    )

close.x=display.contentCenterX+130
close.y=display.contentCenterY-140
sceneGroup:insert(close)


  
	
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object

    if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene
       -- parent:resumeGame()
       
    end
end

-- By some method (a "resume" button, for example), hide the overlay

scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )
return scene