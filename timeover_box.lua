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


local background = display.newImage( sceneGroup,"timeup_box.png")
background:scale( 0.75, 0.75)
background.x=display.contentCenterX
background.y=display.contentCenterY



local reload_bt = widget.newButton(
    {
        width = 50,
        height = 50,
        defaultFile = "reload_bt_org.png",
        overFile = "reload_bt_org.png",
        --label = "bt_reload",
        onEvent = function ( )
          reload=true
          composer.hideOverlay( "fade", 400 )   

        end
    }
)

reload_bt.x = display.contentCenterX+50
reload_bt.y =display.contentCenterY+80
  sceneGroup:insert(reload_bt)


  local menu_bt = widget.newButton(
    {
        width = 50,
        height = 50,
        defaultFile = "menu_bt_org.png",
        overFile = "menu_bt_org.png",
        --label = "bt_reload",
        onEvent = function ( )
        	menu=true
          composer.hideOverlay( "fade", 400 )


        end
    }
)

menu_bt.x = display.contentCenterX-50
menu_bt.y = display.contentCenterY+80
  sceneGroup:insert(menu_bt)
	


  
	
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object

    if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene
       -- parent:resumeGame()
       if(reload==true)then
        print("called reload_overlay")
          parent:reload_overlay()
          
          reload = false
       end
       if(menu==true)then
       	 composer.removeScene( "category")
          composer.gotoScene( "category")
         -- parent:ok_overlay()
          menu = false
       end
    end
end

-- By some method (a "resume" button, for example), hide the overlay

scene:addEventListener( "create", scene )
scene:addEventListener( "hide", scene )
return scene