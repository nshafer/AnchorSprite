AnchorSprite
============

Adding anchor support to the built-in Sprite.  All rotations and scale operations will happen relative to the
set anchor point instead of to the origin.  The default anchor point is {0,0} so unless you change it, Sprites will
behave normally.

#Install:

Just add the Matrix.lua and Sprite.lua to your project.  All Sprite objects will now have the new Anchor
support, but will act normally otherwise.

#New functions

This adds a few new functions to the Sprite class:

###Sprite:setAnchor(x, y)
	Sets the anchorpoint of the sprite that affects the point at which rotation and scaling take place around.

	Parameters:
		x: (number) The x coordinate of the anchor point.  Usually between [0, 1]
		y: (number) The y coordinate of the anchor point.  Usually between [0, 1]

###Sprite:getAnchor()
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


