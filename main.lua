-- Sprite with anchor support
-- For the demo use your keyboard in the desktop player after the animation completes
--   Left and right: move left and right
--   Up and down: scale increase and decrease
--   X and Y: rotate counter-clockwise and clockwise

local _W = application:getContentWidth()
local _H = application:getContentHeight()

local fontFace = "NotoSans-Regular.ttf"
local fontSize = 24

function createBox(width, height, lineStyle)
	local box = Shape.new()
	box:setLineStyle(unpack(lineStyle))
	box:beginPath()
	box:moveTo(0,0)
	box:lineTo(width,0)
	box:lineTo(width,height)
	box:lineTo(0,height)
	box:closePath()
	box:endPath()
	stage:addChild(box)
	return box
end

-- Create a blue box with default anchor
local box1  = createBox(75,75, {2, 0x0000FF, 1})
local box1_W = box1:getWidth()
local box1_H = box1:getHeight()

-- Create a red box with .5 anchor
local box2 = createBox(100,100, {2, 0xFF0000, 1})
local box2_W = box2:getWidth()
local box2_H = box2:getHeight()
box2:setAnchor(.5)

-- Create green box as a child of the red box
local box3 = createBox(100,100, {2, 0x00FF00, 1})
box3:setAnchor(.5)
box3:setScale(.5)
box2:addChild(box3)

-- Randomly move the blue box somewhere
box1:setPosition(math.random(0,_W), math.random(0,_H))
box1:setRotation(math.random(-360,360))
box1:setScale(math.random(5,30)/10)

-- Randomly move the red box somewhere
box2:setPosition(math.random(0,_W), math.random(0,_H))
box2:setRotation(math.random(-360,360))
box2:setScale(math.random(5,30)/10)

-- Create a black text field with default anchor
local text1 = TextField.new(TTFont.new(fontFace, fontSize), "This has 0,0 anchor")
local text1_W = text1:getWidth()
stage:addChild(text1)

-- Randomly move the black text somewhere
text1:setPosition(math.random(0,_W), math.random(0,_H))
text1:setRotation(math.random(-360,360))
text1:setScale(math.random(5,30)/10)

-- Create a teal text field with middle anchor
local text2 = TextField.new(TTFont.new(fontFace, fontSize), "This has .5,.5 anchor")
local text2_W = text2:getWidth()
text2:setAnchor(0.5)
text2:setTextColor(0x00FFFF)
stage:addChild(text2)

-- Randomly move the teal text somewhere
text2:setPosition(math.random(0,_W), math.random(0,_H))
text2:setRotation(math.random(-360,360))
text2:setScale(math.random(5,30)/10)

-- Animate box1, box2, text1 and text2 so they all end up centered
local tweenBox1 = GTween.new(box1, 5, {x=_W/2 - box1_W/2, y=_H/2 - box1_H/2, scaleX=1, scaleY=1, rotation=0}, {ease=easing.inOutCubic, dispatchEvents=true})
local tweenBox2 = GTween.new(box2, 5, {x=_W/2 - box2_W/2, y=_H/2 - box2_H/2, scaleX=1, scaleY=1, rotation=0}, {ease=easing.inOutCubic, dispatchEvents=true})
local tweenText1 = GTween.new(text1, 5, {x=_W/2 - text1_W/2, y=(_H - fontSize*.75) / 2 + fontSize*.75, scaleX=1, scaleY=1, rotation=0}, {ease=easing.inOutCubic})
local tweenText2 = GTween.new(text2, 5, {x=_W/2 - text2_W/2, y=(_H - fontSize*.75) / 2 + fontSize*.75, scaleX=1, scaleY=1, rotation=0}, {ease=easing.inOutCubic})

function onKeyUp(event)
	print("onKeyUp", event.keyCode)
	if event.keyCode == KeyCode.LEFT then
		box1:setX(box1:getX() - 5)
	elseif event.keyCode == KeyCode.RIGHT then
		box1:setX(box1:getX() + 5)
	elseif event.keyCode == KeyCode.UP then
		box1:setScaleX(box1:getScaleX() + .1)
		box1:setScaleY(box1:getScaleY() + .1)
	elseif event.keyCode == KeyCode.DOWN then
		box1:setScaleX(box1:getScaleX() - .1)
		box1:setScaleY(box1:getScaleY() - .1)
	elseif event.keyCode == KeyCode.X then
		box1:setRotation(box1:getRotation() - 10)
	elseif event.keyCode == KeyCode.Y then
		box1:setRotation(box1:getRotation() + 10)
	end
end

tweenBox1:addEventListener("complete", function()
	stage:addEventListener(Event.KEY_UP, onKeyUp)
end)

