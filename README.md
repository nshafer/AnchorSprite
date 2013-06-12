AnchorSprite
============

Adding anchor support to the built-in Sprite.  All position, rotation and scale operations will happen relative to the set anchor point instead of to the origin (0,0).  The default anchor point is (0,0) so unless you change it, Sprites will behave normally.

##Install

Just add the Matrix.lua and AnchorSprite.lua to your project.  All Sprite objects will now have the new Anchor support, but will act normally otherwise.  The new code is only enabled if you set an anchor point other than (0,0).

#Example

```lua
local s = Sprite.new()
s:setAnchorPoint(.5, .5)
s:setPosition(100, 100)
s:setRotation(45)
s:setScale(2)
```

##Drawbacks

This moves a lot of calculations into the Lua space instead of the base of Gideros for all objects based on the Sprite object that have an anchor set. It will come at the cost of increased overhead, especially new table lookups and a lot of matrix multiplication.  In practice it seems to be negligible, but keep that in mind if you are modifying the position, rotation or scale of a lot of Sprites with non-zero anchors at once.

Also, only things that call Sprite functions in Lua will be affected by this.  That means that MovieClip will bypass all of this code and will make objects react as if they have an anchor of (0,0) again.  You have to use GTween instead of MovieClip with this.

##New functions

This adds two new functions to the Sprite class:

####Sprite:setAnchorPoint(x[, y])
	Sets the anchorpoint of the sprite that affects the point at which rotation and scaling take place around.

	Parameters:
		x: (number) The x coordinate of the anchor point.  Usually between [0, 1].
		y: (number) The y coordinate of the anchor point.  Usually between [0, 1].  If not given, uses x value.

####Sprite:getAnchorPoint()
	Returns the x and y coordinates of the anchor point.

	Returns:
		x, y
