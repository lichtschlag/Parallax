#Parallax
is a small test of the UIMotionEffect. Unfortunately, I found the it comes with some limitations that were not apparent from the WWDC presentations:

* the update to the estimation of the neutral view point is quite abrupt and produces an un-animated jump in the graphics. You ca  see this in the icon grid on the Spring board as well if you look closely, but it is more visible here with the amplified movement.
* One can only animate views (not layers)
* One cannot get the values directly to use as one would see fit, e.g., for non-linear transformations