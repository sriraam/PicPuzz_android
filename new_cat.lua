local composer = require( "composer" )
local gameState = require("gamestate")

local scene = composer.newScene()
local widget = require( "widget" )
local reload=false
local menu =false


function  scene:create(event)
	local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent


local background = display.newImage( sceneGroup,"dialog_not_enough.png")
background:scale( 0.75, 0.75)
background.x=display.contentCenterX
background.y=display.contentCenterY



local ok_bt = widget.newButton(
    {
        width = 65,
        height = 65,
        defaultFile = "ok_bt.png",
        overFile = "ok_bt.png",
        --label = "bt_reload",
        onEvent = function ( )
          reload=true
          composer.hideOverlay( "fade", 400 )   

        end
    }
)

ok_bt.x = display.contentCenterX
ok_bt.y = display.contentCenterY+55
  sceneGroup:insert(ok_bt)

  end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object

    if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene
       -- parent:resumeGame()
       
       --[[if(reload==true)then
        print("called reload_overlay")
         parent:reload_overlay()
          
          reload = false
       end

       if(menu==true)then
       	 composer.removeScene( "category")
          composer.gotoScene( "category")
         -- parent:ok_overlay()
          menu = false
       end--]]
    end
end

-- By some method (a "resume" button, for example), hide the overlay

scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )
return scene