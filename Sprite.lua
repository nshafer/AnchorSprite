Sprite._anchorX = 0
Sprite._anchorY = 0
Sprite._positionX = 0
Sprite._positionY = 0
Sprite._scaleX = 1
Sprite._scaleY = 1
Sprite._rotation = 0

-- New function to apply all transforms whenever anything changes
function Sprite:applyTransforms()
	local matrix = Matrix.new()
	
	-- set position
	matrix:translate(self._positionX, self._positionY)
	
	-- set rotation and scale
	matrix:translate(self._anchorX, self._anchorY)
	matrix:rotate(self._rotation)
	matrix:scaleX(self._scaleX)
	matrix:scaleY(self._scaleY)
	matrix:translate(-self._anchorX, -self._anchorY)
	
	self:setMatrix(matrix)
end

-- Intercept Sprite's set and get functions for position, scale and rotation
Sprite._set = Sprite.set
function Sprite:set(key, value)
	if value then
		if key == "anchorX" then
			self._anchorX = self:getWidth() * value
		elseif key == "anchorY" then
			self._anchorY = self:getHeight() * value
		elseif key == "x" then
			self._positionX = value
		elseif key == "y" then
			self._positionY = value
		elseif key == "scaleX" then
			self._scaleX = value
		elseif key == "scaleY" then
			self._scaleY = value
		elseif key == "rotation" then
			self._rotation = value
		else
			self:_set(key, value)
		end
		self:applyTransforms()
	end
end

Sprite._get = Sprite.get
function Sprite:get(key)
	if key == "anchorX" then
		return self._anchorX
	elseif key == "anchorY" then
		return self._anchorY
	elseif key == "x" then
		return self._positionX
	elseif key == "y" then
		return self._positionY
	elseif key == "scaleX" then
		return self._scaleX
	elseif key == "scaleY" then
		return self._scaleY
	elseif key == "rotation" then
		return self._rotation
	else
		return self:_get(key)
	end
end

-- New functions for setting the anchor
function Sprite:getAnchor()
	return self:get("anchorX"), self:get("anchorY")
end

function Sprite:setAnchor(x, y)
	self:set("anchorX", x)
	self:set("anchorY", y or x)
end

function Sprite:getAnchorX()
	return self:get("anchorX")
end

function Sprite:setAnchorX(x)
	self:set("anchorX", x)
end

function Sprite:getAnchorY()
	return self:get("anchorY")
end

function Sprite:setAnchorY(y)
	self:set("anchorY", y)
end

-- Position functions
function Sprite:getPosition()
	return self:get("x"), self:get("y")
end

function Sprite:setPosition(x, y)
	self:set("x", x)
	self:set("y", y)
end

function Sprite:getX()
	return self:get("x")
end

function Sprite:setX(x)
	self:set("x", x)
end

function Sprite:getY()
	return self:get("y")
end

function Sprite:setY(y)
	self:set("y", y)
end

-- Scale functions
function Sprite:getScale()
	return self:get("scaleX"), self:get("scaleY")
end

function Sprite:setScale(x, y)
	self:set("scaleX", x)
	self:set("scaleY", y or x)
end

function Sprite:getScaleX()
	return self:get("scaleX")
end

function Sprite:setScaleX(x)
	self:set("scaleX", x)
end

function Sprite:getScaleY()
	return self:get("scaleY")
end

function Sprite:setScaleY(y)
	self:set("scaleY", y)
end

-- Rotation functions
function Sprite:getRotation()
	return self:get("rotation")
end

function Sprite:setRotation(rotation)
	self:set("rotation", rotation)
end

