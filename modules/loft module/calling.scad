// OpenSCAD loft module. You most likely want 'loft.scad' (the yellow one).

include <loft.scad>

// Add the same amount of points for upper and lower face,
// preferably clockwise (looking from above).
// If those things are unclear, try combinations 
// of upper/lower, clockwise/counterclockwise.
// Start over matching points, otherwise the polyhedron will be twisted.
// It is possible defining the points by code.

my_upper_points = [ [0,20,20], [5,12.5,15], [10,5,10], [15,-2.5,5], 
        [20,-10,0], [10,-10,5], [0,-10,10], [-10,-10,15],       
        [-20,-10,20], [-15,-2.5,20], [-10,5,20], [-5,12.5,20] ];   
my_lower_points = [ [0,10,-20], [12,30,-20], [8,5,-20], [35,0,-20], 
        [8,-5,-20], [12,-30,-20], [0,-10,-20], [-12,-30,-20], 
        [-8,-5,-20], [-35,0,-20], [-8,5,-20], [-12,30,-20] ];   
        
loft(my_upper_points, my_lower_points, 50); // Last number: number of horizontal layers.