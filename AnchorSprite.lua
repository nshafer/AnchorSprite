----------------------------------------
-- AnchorSprite functions
-- https://github.com/nshafer/AnchorSprite
----------------------------------------

-- The MIT License (MIT)

-- Copyright (c) 2013 Nathan Shafer

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

AnchorSprite = {}

-- New function to apply all transforms whenever anything changes
function AnchorSprite:_applyTransforms()
	-- Create a new identity matrix
	local matrix = Matrix.new()
	
	-- Zero ourselves out so we can get accurate width and height
	self:setMatrix(matrix)
	local anchorOffsetX = self._anchorPointX * self:getWidth()
	local anchorOffsetY = self._anchorPointY * self:getHeight()
	
	-- set position
	matrix:translate(self._positionX, self._positionY)
	
	-- concatenate rotation and scale matrices
	matrix:rotate(self._rotation)
	matrix:scaleX(self._scaleX)
	matrix:scaleY(self._scaleY)
	
	-- concatenate offset to new origin in modified coordinate space
	matrix:translate(-anchorOffsetX, -anchorOffsetY)
	
	-- Apply the new matrix
	self:setMatrix(matrix)
end

-- Intercept Sprite's set and get functions for position, scale and rotation
function AnchorSprite:set(key, value)
	if value then
		if key == "x" then
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
			self._anchorBackup.set(self, key, value)
		end
		self:_applyTransforms()
	end
end

--Sprite._get = Sprite.get
function AnchorSprite:get(key)
	if key == "x" then
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
		return self._anchorBackup.get(self, key)
	end
end

-- Position functions
function AnchorSprite:getPosition()
	return self:get("x"), self:get("y")
end

function AnchorSprite:setPosition(x, y)
	self:set("x", x)
	self:set("y", y)
end

function AnchorSprite:getX()
	return self:get("x")
end

function AnchorSprite:setX(x)
	self:set("x", x)
end

function AnchorSprite:getY()
	return self:get("y")
end

function AnchorSprite:setY(y)
	self:set("y", y)
end

-- Scale functions
function AnchorSprite:getScale()
	return self:get("scaleX"), self:get("scaleY")
end

function AnchorSprite:setScale(x, y)
	self:set("scaleX", x)
	self:set("scaleY", y or x)
end

function AnchorSprite:getScaleX()
	return self:get("scaleX")
end

function AnchorSprite:setScaleX(x)
	self:set("scaleX", x)
end

function AnchorSprite:getScaleY()
	return self:get("scaleY")
end

function AnchorSprite:setScaleY(y)
	self:set("scaleY", y)
end

-- Rotation functions
function AnchorSprite:getRotation()
	return self:get("rotation")
end

function AnchorSprite:setRotation(rotation)
	self:set("rotation", rotation)
end


----------------------------------------
-- Sprite additions
----------------------------------------
Sprite._anchorSupport = false
Sprite._anchorBackup = {}
Sprite._anchorPointX = 0
Sprite._anchorPointY = 0
Sprite._positionX = 0
Sprite._positionY = 0
Sprite._scaleX = 1
Sprite._scaleY = 1
Sprite._rotation = 0

-- New functions in Sprite for setting the anchor
function Sprite:getAnchorPoint()
	return self._anchorPointX, self.anchorPointY
end

function Sprite:setAnchorPoint(x, y)
	self._anchorPointX = x
	self._anchorPointY = y or x
	
	if x ~= 0 or y ~= 0 and not self._anchorSupport then
		self:_enableAnchorSupport()
	elseif x == 0 and y == 0 and self._anchorSupport then
		self:_disableAnchorSupport()
	end
end

function Sprite:_enableAnchorSupport()
	self._anchorSupport = true
	
	-- Get current values
	self._positionX = self:getX()
	self._positionY = self:getY()
	self._scaleX = self:getScaleX()
	self._scaleY = self:getScaleY()
	self._rotation = self:getRotation()
	
	-- Override Sprite functions with AnchorSprite versions
	for k,v in pairs(AnchorSprite) do
		if type(v) == "function" then
			--print("AnchorSprite", k, v)
			if self[k] then
				-- Backup existing function
				self._anchorBackup[k] = Sprite[k]
			end
			
			-- Replace with AnchorSprite version
			self[k] = v
		end
	end
	
	self:_applyTransforms()
end

function Sprite:_disableAnchorSupport()
	self._anchorSupport = false
	
	-- Restore backed up functions
	for k,v in pairs(self._anchorBackup) do
		self[k] = self._anchorBackup[k]
	end
	
	-- Set current values
	self:setMatrix(Matrix.new())
	self:setPosition(self._positionX, self._positionY)
	self:setScale(self._scaleX, self._scaleY)
	self:setRotation(self._rotation)
end


