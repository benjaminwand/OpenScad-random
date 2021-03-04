// this is a utility for extruding in all the planes from polyhedra

// examples
/*
my_points = [[1, 2], [5, 2], [3, 8]];
my_extrude = 3;

color("yellow") xy_extrude(my_points, my_extrude, false);
color("red") xz_extrude(my_points, my_extrude, false);
color("blue") yz_extrude(my_points, my_extrude, false);
*/

module xy_extrude(points, height, center = true) {
    linear_extrude(height = height, center = center) 
        polygon(points = points); 
};

module xz_extrude(points , height , center = true){
    rotate([90, 0, 0])
        mirror([0, 0, 1])        
            xy_extrude(points, height, center);            
};

module yz_extrude(points , height , center = true){
    rotate([90, 0, 90])
        xy_extrude(points, height, center);
};