
local gameState = require( "gamestate" )

local composer = require( "composer" )

local scene = composer.newScene()
local json = require("json")

local reward_table={}
local filePath_stars = system.pathForFile( "pp_rewards.json", system.DocumentsDirectory )

local football_pic;
local mythology_pic;
local star_count
local widget = require "widget"
local button1, button2,button3,button4,button5
local cat_lock=0 
local i=3
local j=1
 local scount_text
local  totalstars = 0
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- This is a good place to put variables and functions that need to be available scene
-- wide.
-- -----------------------------------------------------------------------------------


local options = {
    isModal = true,
    effect = "zoomOutIn",
    time = 0,
   -- params = {
     --   sampleVar = "my sample variable"
    --}
}

local function gotoGame()

    composer.removeScene( "levels" )
	composer.gotoScene( "levels",{effect = "slideLeft",time = 500})
end

local function quit()
	composer.gotoScene( "quit" )
end

local function loadrewards()
  local file = io.open( filePath_stars, "r" )

    if file then
        local contents = file:read( "*a" )
        io.close( file )
        reward_table = json.decode( contents )
    end

    if ( reward_table == nil or #reward_table == 0 ) then
--first pos hold the remaining seconds for the whole categoty
        reward_table ={ {0,0},--used to count the total stars and spent
                        {1,1,1,1},--last four category lock

                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                      { 0, 0, 0, 0, 0, 0, 0, 0, 0 }
                    }
    

    end
end

function  count_stars( )
    local count=0

 for  i=3,11 do
    for  j=1,9 do
            print( "i "..i )
    print("j "..j)
   -- print("reward_table[][]".." i :"..i.." j :"..j.." value "..reward_table[i][j])
     if(reward_table[i][j]~=0)then
     count = count+reward_table[i][j]
       else
       end
      end
    end
    print( reward_table[1][1] )
  reward_table[1][1]=count
   
    totalstars=reward_table[1][1]-reward_table[1][2]
    --gameState.stars=
        print( "2"..reward_table[1][1] )

end
--[[
function unlock_category()
if(totalstars>=20)then
reward_table[1][2]=reward_table[1][2]-20
count_stars()

 end
end
--]]

function save_reward(  )
    local file=io.open( filePath_stars,"w" )

    file:write( json.encode( reward_table) )
    io.close( file )  
end

function scene:unlock_overlay()

reward_table[1][2]=reward_table[1][2]+20
reward_table[2][cat_lock]=0
count_stars()
scount_text.text=tostring( totalstars)
save_reward()


end

local widget = require( "widget" )

-- ScrollView listener
local function scrollListener( event )

    local phase = event.phase
    if ( phase == "began" ) then print( "Scroll view was touched" )
    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
    elseif ( phase == "ended" ) then print( "Scroll view was released" )
    end

    -- In the event a scroll limit is reached...
    if ( event.limitReached ) then
        if ( event.direction == "up" ) then print( "Reached bottom limit" )
        elseif ( event.direction == "down" ) then print( "Reached top limit" )
        elseif ( event.direction == "left" ) then print( "Reached right limit" )
        elseif ( event.direction == "right" ) then print( "Reached left limit" )
        end
    end
   return true
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local label = display.newText(sceneGroup, "Select level", 20, 20, "Verdana", 14 )
label:setTextColor( 255, 255, 255 )



   local backgr = display.newImageRect(sceneGroup,"category_bg_27.jpg", 652,1217 )
   backgr:scale( 0.5, 0.5 )
   backgr.x = display.contentCenterX
   backgr.y = display.contentCenterY

        loadrewards()
        count_stars( )


local scrollView = widget.newScrollView(
    {
       -- top = 0,
        --left = 0,
        width = display.viewableContentWidth,
        height = display.viewableContentHeight,
        scrollWidth = display.viewableContentWidth,
        scrollHeight = display.viewableContentHeight,
        horizontalScrollDisabled=true,
        isBounceEnabled=false,
        hideBackground=true,
        hideScrollBar=true,
        friction=1.5,
        bottomPadding=70,

        listener = scrollListener
    }
)


sceneGroup:insert(scrollView)
--local cat1=display.

local button1 = widget.newButton(
    {
        width = 110,
        height = 110,
        defaultFile = "category/cricket_box.png",
       -- label = "CRICKET",
        
        onRelease=function()

gameState.category = 1
gotoGame()
end
    }
)

-- Center the button
button1.x = display.contentCenterX-75
button1.y = display.contentCenterY-125

sceneGroup:insert(button1)

local button2 = widget.newButton(
    {
        width = 110,
        height = 110,
        defaultFile = "category/myster_won.png",
        --label = "TENNIS",
        
        onRelease=function ()

gameState.category = 2

gotoGame()
end


    }
)

-- Center the button
button2.x = display.contentCenterX+75
button2.y = display.contentCenterY-125
   
sceneGroup:insert(button2)

local button3 = widget.newButton(
    {
        width = 110,
        height = 110,
        defaultFile = "category/city_box.png",
       -- label = "RETRO CARTOONS",
        
        onRelease=function ()

gameState.category = 3

gotoGame()
end

    }
)

-- Center the button
button3.x = display.contentCenterX-75
button3.y = display.contentCenterY
   
sceneGroup:insert(button3)

local button4 = widget.newButton(
    {
        width = 110,
        height = 110,
        defaultFile = "category/cartoon_box.png",
     --   label = "FOOT BALL",
        
        onRelease=function ()

gameState.category = 3

gotoGame()
end

    }
)

-- Center the button
button4.x = display.contentCenterX-75
button4.y = display.contentCenterY+125
   
sceneGroup:insert(button4)


local button5 = widget.newButton(
    {
        width = 110,
        height = 110,
        defaultFile = "category/leader_box.png",
       -- label = "BHEEM",
        
        onRelease=function ()

gameState.category = 3

gotoGame()
end


    }
)

-- Center the button
button5.x = display.contentCenterX-75
button5.y = display.contentCenterY+250
   
sceneGroup:insert(button5)

local button6 = widget.newButton(
    {
        width = 110,
        height = 110,
        defaultFile = "category/intel_box.png",
        --label = "super heros",
        
        onRelease=function ()

gameState.category = 3

gotoGame()
end


    }
)

-- Center the button
button6.x = display.contentCenterX+75
button6.y = display.contentCenterY+125
   sceneGroup:insert(button6)


local button7 = widget.newButton(
    {
        width = 110,
        height = 110,
        defaultFile = "category/tennis_box.png",
        --label = "Abstract challenge 2",
        
        onRelease=function ()

gameState.category = 3

gotoGame()
end



    }
)

-- Center the button
button7.x = display.contentCenterX+75
button7.y = display.contentCenterY
   sceneGroup:insert(button7)


local button8 = widget.newButton(
    {
        width = 110,
        height = 110,
        defaultFile = "category/car_box.png",
        --label = "Abstract challenge 2",
        
        onRelease=function ()

gameState.category = 3

gotoGame()
end
-- launch the game scene


    }
)

-- Center the button
button8.x = display.contentCenterX+75
button8.y = display.contentCenterY+250
   sceneGroup:insert(button7)


--To assign the picture of categoty according to locked status
if(reward_table[2][1]==0)then
    football_pic ="category/football_box.png";
else
    football_pic ="category/football_locked.png";
  end  
--local b9_string=
local button9 = widget.newButton(
    {
        width = 110,
        height = 110,
        defaultFile = football_pic,
        --label = "Abstract challenge 2",
        
        onRelease=function ()
            if(reward_table[2][1]==0)then
   cat_lock=1

gameState.category = 3

gotoGame()
print( totalstars )
elseif(totalstars>=20)then

--unlock_overlay()
composer.showOverlay("unlock",options)
--composer.showOverlay( "new_cat",options)
else
    composer.showOverlay( "new_cat",options)
end 
end
-- launch the game scene


    }
)

-- Center the button
button9.x = display.contentCenterX-75
button9.y = display.contentCenterY+375
   sceneGroup:insert(button7)
 


--To assign the picture of categoty according to locked status  
if(reward_table[2][2]==0)then
    mythology_pic ="category/india_myth.png";
else
    mythology_pic = "category/ind_myth_locked.png";
  end  


local button10 = widget.newButton(
    {
        width = 110,
        height = 110,
        defaultFile = mythology_pic,
        --label = "Abstract challenge 2",
       
        onRelease=function ()
            if(reward_table[2][2]==0)then
   cat_lock=2
gameState.category = 3

gotoGame()
print( totalstars )
elseif(totalstars>=20)then

--unlock_overlay()
composer.showOverlay("unlock",options)
--composer.showOverlay( "new_cat",options)
else
    composer.showOverlay( "new_cat",options)
end 

end
-- launch the game scene
    }
)

-- Center the button
button10.x = display.contentCenterX+75
button10.y = display.contentCenterY+375
   sceneGroup:insert(button7)       

scrollView:insert( button1 )
scrollView:insert( button2 )
scrollView:insert( button3 )
scrollView:insert( button4 )

scrollView:insert( button5 )
scrollView:insert( button6 )
scrollView:insert( button7 )
scrollView:insert( button8 )
scrollView:insert( button9 )
scrollView:insert( button10 )



--print(testtable[3][2])
 local banner = display.newImageRect(sceneGroup,"category_banner.png", 652,212)
   banner:scale( .5, .5 )
   banner.x = display.contentCenterX
  banner.y = display.contentCenterY-230

   local bottom = display.newImageRect(sceneGroup,"category_bottom_wh.png", 652,240)
   bottom:scale( .5, .5 )
   bottom.x = display.contentCenterX
  bottom.y = display.contentCenterY+275

 star_count=display.newImageRect(sceneGroup,"star_count.png",196,68)
star_count:scale( .60,.60)
star_count.x=display.contentCenterX+90
star_count.y=display.contentCenterY-262

       
        print( "bott"..reward_table[1][1] )
      scount_text=display.newText( sceneGroup,tostring(totalstars), star_count.x+15, star_count.y+5 , "CarterOne",15 )
          scount_text:setFillColor( 1,1,1,1)


--local scount_text=display.newText( sceneGroup,totalstars, star_count.x+15, star_count.y+ , "CarterOne",10 )
--scount_text:setFillColor( 1,1,1,1)


local menu = widget.newButton(
    {
        width = 50,
        height = 50,
        defaultFile = "back_btn.png",
     --   label = "FOOT BALL",
        
        onRelease=function ()
    composer.gotoScene("menu",{effect = "slideRight",time = 500})

end
-- launch the game scene


    }
)

-- Center the button
menu.x = display.contentCenterX-115
menu.y = display.contentCenterY+235
   
sceneGroup:insert(menu)

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
    --    loadrewards()
    --    count_stars( )
        
    --  local scount_text=display.newText( sceneGroup,totalstars, star_count.x+15, star_count.y , "CarterOne",10 )
    --      scount_text:setFillColor( 1,1,1,1)
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
