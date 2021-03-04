// Rainbow gradient in OpenSCAD, just in case I (or somebody else) needs it once again

// Example
many_colors = 15; // Determins width of gradient
            
for(i=[-20:0.1:20]) 
    color([cos(many_colors*i)/2+0.5, 
        -sin(many_colors*i)/2+0.5, 
        -cos(many_colors*i)/2+0.5])
    translate([i, 0, 0])
    cube([0.1, 0.5, 10]);


//Module for rainbow dots on points
module rainbow 
    (points,		    // A vector of points, the only must-have
	many_colors = 20,   // Determins width of gradient
	size_sphere = 1)    // Depends on the size of your model
{
for (i= [0 : len(points)-1 ])
    color([cos(many_colors*i)/2+0.5, 
        -sin(many_colors*i)/2+0.5, 
        -cos(many_colors*i)/2+0.5, 
        1])
    translate(points[i]) sphere(size_sphere);
}