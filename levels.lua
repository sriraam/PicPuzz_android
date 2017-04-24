
local gameState = require( "gamestate" )



local composer = require( "composer" )

local scene = composer.newScene()

local levels = gameState.level
local starGroup
local category = gameState.category
local json = require( "json" )

local filePath_stars = system.pathForFile( "pp_rewards.json", system.DocumentsDirectory )

local filePath = system.pathForFile( "pp_levelss.json", system.DocumentsDirectory )

local widget = require "widget"
local  level_table ={}

local star_dis
local level
local totalstars
local level_lock={}
local level_access={}
local  reward_table={}
local offsetx
local offsety
local stars=gameState.stars
local star_gen
local options = {
    isModal = true,
    effect = "zoomOutIn",
    time = 0,
   -- params = {
     --   sampleVar = "my sample variable"
    --}
}
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- This is a good place to put variables and functions that need to be available scene
-- wide.
-- -----------------------------------------------------------------------------------
local function loadlevels()

    local file = io.open( filePath, "r" )

    if file then
        local contents = file:read( "*a" )
        io.close( file )
       -- print(contents)
        level_table = json.decode( contents )
        print(contents)
    end

    if ( level_table == nil or #level_table == 0 ) then
--first pos hold the remaining seconds for the whole categoty
print("File is loaded")
        level_table = {{1,1,1,0,0,0,0,0,0},
                       {1,1,1,0,0,0,0,0,0},
                       {1,1,1,0,0,0,0,0,0},
                       {1,1,1,0,0,0,0,0,0},
                       {1,1,1,0,0,0,0,0,0},
                       {1,1,1,0,0,0,0,0,0},
                       {1,1,1,0,0,0,0,0,0},
                       {1,1,1,0,0,0,0,0,0},
                       {1,1,1,0,0,0,0,0,0},
                  }
    end
   -- print("categoty :"category)
--print(level_table[category][1])
    
end

function star_gen( )
    

local i=1
--print("reward_table"..reward_table[category])
while(level_table[category][i]~=0 and i<10)do
    for j=1,3 do

if(j<=reward_table[category+2][i])then    
star_dis = display.newImage(starGroup,"star_mini.png",15,16)
else
 star_dis = display.newImage( starGroup,"level_star2.png",15,16)
end
--star_dis:scale( .75,.75)
if(level_table[category][i]==1)then
    
star_dis.x=(level_access[i].x-20)+((j-1)*(20))
star_dis.y=level_access[i].y+22
end
  end
  i=i+1
end

end


local function savelevel()


    local file = io.open( filePath, "w" )

    if file then
        file:write( json.encode( level_table ) )
        io.close( file )
    end
end


function save_reward(  )
    local file=io.open( filePath_stars,"w" )
if file then 
    file:write( json.encode( reward_table) )
    io.close( file )  
end
end


local function gotoGame(event)
  --  local phase = event.phase
--pass the selected level to the gamestate
--for i=1,9 do
--if()

--end


    if ( event.phase == "began" ) then
       
        for  i=1,9 do
if(event.target==level_access[i])then
gameState.level=i
end
     end
    elseif ( event.phase == "ended" ) then
       
    composer.removeScene( "game" )
    composer.gotoScene( "game" ,{effect = "zoomOutInFade",time = 250})
    end
    return true 
end

function  count_stars( )
    local count=0

 for  i=3,11 do
    for  j=1,9 do
          --  print( "i "..i )
   -- print("j "..j)
   -- print("reward_table[][]".." i :"..i.." j :"..j.." value "..reward_table[i][j])
     if(reward_table[i][j]~=0)then
     count = count+reward_table[i][j]
       else
       end
      end
    end
 --   print( reward_table[1][1] )
  reward_table[1][1]=count
   
    totalstars=reward_table[1][1]-reward_table[1][2]
    --gameState.stars=
   --     print( "2"..reward_table[1][1] )
       -- return totalstars

end




function scene:unlock_overlay()

reward_table[1][2]=reward_table[1][2]+2
--reward_table[2][cat_lock]=0
level_table[category][levels]=1
count_stars()
--scount_text.text=tostring( totalstars)
save_reward()
savelevel()

--recheck the images table and pos here
--level_arrangement()
--star_gen()
end

local function quit()
	composer.gotoScene( "quit" )
end

--local i
local function level_unlock_image()
local obj = display.newImageRect(levelGroup,"level_unlock.png",82,93)
return obj
end

local function level_lock_image()
local obj = display.newImageRect(levelGroup,"level_lock.png",85,101)
return obj
end


local function loadrewards()
  local file = io.open( filePath_stars, "r" )

    if file then
        local contents = file:read( "*a" )
        io.close( file )
        reward_table = json.decode( contents )
        print("reward"..contents)
        print(reward_table[2][2])
    end
--print("reward"..contents)
    if ( reward_table == nil or #reward_table == 0 ) then
--first pos hold the remaining seconds for the whole categoty
        reward_table ={{0,0},
                       {1,1,1,1},   
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


function unlock_level(event)

if ( event.phase == "began" ) then
       
 for  i=1,9 do
   if(event.target==level_access[i])then
      levels=i
      print("levels"..levels)
      count_stars()
   end
  end
 elseif ( event.phase == "ended" ) then

if(totalstars>=2)then
 composer.showOverlay("unlock_level",options)
else
    composer.showOverlay( "new_cat",options)

 end

end

end


-----------------------------------------------------------------------------
--Level tile arrangement done procedurely inorder to save memory
--and it id depend upon the panel
--no need to place tile seperatly inorder to change the position it does automatically..
-----------------------------------------------------------------------------

function level_arrangement() 

local adjust_x=0
local adjust_y=0
for i=1,3 do
   -- level.y=offsety
    for j=1,3 do
if(level_table[category][(3*i)-(3-j)]==1)then
    level=level_unlock_image()
    table.insert(level_access,level)
    
   -- print(level_access[(3*i)-(3-j)])
    level_access[(3*i)-(3-j)]:addEventListener("touch",gotoGame)
   -- star_gen()
    adjust_x=0
    adjust_y=0


 elseif(level_table[category][(3*i)-(3-j)]==0)then
     level=level_lock_image()
     table.insert(level_access,level)
   --  print(level_access[(3*i)-(3-j)])
   --$$$$$$$ cmmented below line to avoid unlock level feature
  --   level_access[(3*i)-(3-j)]:addEventListener("touch",unlock_level)--add levels in level_lock table

     --since we may not use this ,it simply visible no function
   -- table.insert(level_access,level)

     adjust_x=-5
     adjust_y=-3
      end
      level.x=adjust_x+offsetx+((j-1)*(level.width+15))
     level.y=adjust_y+offsety

     if(level_table[category][(3*i)-(3-j)]==1)then
      local black=display.newText( levelGroup,(3*i)-(3-j), (level.x-78)+(level.width),level.y-3,"Skranji-Bold",42 )

     black:setFillColor( 0, 0, 0 )
     display.newText( levelGroup,(3*i)-(3-j), (level.x-80)+(level.width),level.y-5,"Skranji-Bold",38 )

     elseif(level_table[category][(3*i)-(3-j)]==0)then
    local black=display.newText( levelGroup,(3*i)-(3-j), (level.x-78)+(level.width),level.y+4,"Skranji-Bold",42 )

     black:setFillColor( 0, 0, 0 )
     display.newText( levelGroup,(3*i)-(3-j), (level.x-80)+(level.width),level.y+6,"Skranji-Bold",38 )
     end
   
 end
 
 offsety = offsety + level.height+25
end

end



--[[
for i=1,#level_table do
 if(level_table[i]==1)then
    level[i]=level_unlock_image()
     level[i]:addEventListener("tap",gotoGame)

 elseif(level_table[i]==0)then
     level[i]=level_lock_image()
     level[i]:addEventListener("tap",gotoGame)

 end
end
--]]
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

loadlevels()
savelevel()
  local backgr = display.newImageRect(sceneGroup,"black_bg_light2.jpg", 800,1400 )
  backgr:scale(.5,.41)
  backgr.x = display.contentCenterX
  backgr.y = display.contentCenterY

 --local label = display.newText(sceneGroup, "Select level", 20, 20, "Verdana", 14 )
 --   label:setTextColor( 255, 255, 255 )
local panel=display.newImageRect(sceneGroup,"level_select_panel_edited2.png",682,959)
panel:scale(.46,.5)
panel.x=display.contentCenterX
panel.y=display.contentCenterY+20


 offsetx=panel.x-100
 offsety=panel.y-100

local ribon=display.newImageRect(sceneGroup,"select_puzz.png",424,107)
ribon:scale(.65,.65)
ribon.x=display.contentCenterX
ribon.y=display.contentCenterY-200

   levelGroup=display.newGroup()
  sceneGroup:insert(levelGroup)


starGroup=display.newGroup()
sceneGroup:insert(starGroup)
  --text_group=display.newGroup()
  --sc

  local back_bt = widget.newButton(
    {
        width = 50,
        height = 50,
        defaultFile = "back_btn.png",
        overFile = "back_btn.png",
        --label = "bt_reload",
        onEvent = function ()
        composer.removeScene("category")
          composer.gotoScene("category",{effect = "slideRight",time = 500})

        end
    }
)

back_bt.x = display.contentCenterX-100
back_bt.y = display.contentCenterY+240

  sceneGroup:insert(back_bt)

loadrewards()
level_arrangement()
--create a new scene instead of overlay
--so automatically refreshes the level 
--but how to pass values.?

--local cat1=display.

--checks whether the level table is 1 ,i.e it is unlocked and assigs event listener and its level pic

--initially we are keeping it 9 but it should create procedurally on the no. of level on each category/..
--[[
for i=1,9 do
   -- print(i)
 if(level_table[category][i]==1)then
    level[i]=level_unlock_image()
    level[i]:addEventListener("touch",gotoGame)

 elseif(level_table[category][i]==0)then
     level[i]=level_lock_image()
 end

-- local text = display.newText( i, 0, 0, "Helvetica", 18 )
--text:setTextColor( 0, 0, 0, 255 )
end
    gameState.level=1

--level1=level_unlock_image()
level[1].x=display.contentCenterX-100
level[1].y=display.contentCenterY-100
 --level[1]=level_unlock_image()


--level2=level_lock_image()
level[2].x=display.contentCenterX
level[2].y=display.contentCenterY-100
--level[2]:addEventListener("tap",gotoGame)


level[3].x=display.contentCenterX+100
level[3].y=display.contentCenterY-100

level[4].x=display.contentCenterX-100
level[4].y=display.contentCenterY+20

level[5].x=display.contentCenterX
level[5].y=display.contentCenterY+20

level[6].x=display.contentCenterX+100
level[6].y=display.contentCenterY+20

level[7].x=display.contentCenterX-100
level[7].y=display.contentCenterY+140

level[8].x=display.contentCenterX
level[8].y=display.contentCenterY+140

level[9].x=display.contentCenterX+100
level[9].y=display.contentCenterY+140


--]]
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
        star_gen()
	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

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
