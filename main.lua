-- Sprite with anchor support
-- For the demo use your keyboard in the desktop player
--   Left and right: move left and right
--   Up and down: scale increase and decrease
--   X and Y: rotate counter-clockwise and clockwise

function createBox(width, height, lineStyle)
	local box = Shape.new()
	box:setLineStyle(unpack(lineStyle))
	box:beginPath()
	box:moveTo(0,0)
	box:lineTo(100,0)
	box:lineTo(100,100)
	box:lineTo(0,100)
	box:closePath()
	box:endPath()
	stage:addChild(box)
	return box
end

local box1 = createBox(100,100, {2, 0xFF0000, 1})
box1:setAnchor(.5)
box1:setRotation(30)
box1:setPosition(100,100)
box1:setScale(2)

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
stage:addEventListener(Event.KEY_UP, onKeyUp)