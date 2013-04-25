AnchorSprite
============

Adding anchor support to the built-in Sprite.  All position, rotation and scale operations will happen relative to the set anchor point instead of to the origin (0,0).  The default anchor point is (0,0) so unless you change it, Sprites will behave normally.

#Install

Just add the Matrix.lua and Sprite.lua to your project.  All Sprite objects will now have the new Anchor support, but will act normally otherwise.

#Drawbacks

This moves a lot of calculations into the LUA space instead of the base of Gideros for all objects based on the Sprite object. It will come at the cost of increased overhead, especially new table lookups and a lot of matrix multiplication.  It doesn't seem to be much, but keep that in mind if you are modifying the position, rotation or scale of a lot of Sprites at once.

#New functions

This adds a few new functions to the Sprite class:

###Sprite:setAnchorPoint(x, y)
	Sets the anchorpoint of the sprite that affects the point at which rotation and scaling take place around.

	Parameters:
		x: (number) The x coordinate of the anchor point.  Usually between [0, 1]
		y: (number) The y coordinate of the anchor point.  Usually between [0, 1]

###Sprite:getAnchorPoint()
	Returns the x and y coordinates of the anchor point.

	Returns:
		x, y

###Sprite:setAnchorX(x)
	Sets the x coordinate of the anchor.

	Parameters:
		x: (number) The x coordinate of the anchor point.  Usually between [0, 1]

###Sprite:getAnchorX()
	Returns the x coordinate of the anchor point.

	Returns:
		x

###Sprite:setAnchorY(y)
	Sets the y coordinate of the anchor.

	Parameters:
		y: (number) The y coordinate of the anchor point.  Usually between [0, 1]

###Sprite:getAnchorY()
	Returns the y coordinate of the anchor point.

	Returns:
		y


