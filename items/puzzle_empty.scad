p_x = 19;   // side length of puzzle piece
p_y = 19;   // side length of puzzle piece
p_z = 2;    // height of puzzle piece
d = 0.3;    // distance between puzzle pieces
h_s = 0.35;  // knob sizes
h_d = 0.12;  // knob distance
amount = [10, 10]; // how many pieces one wants
$fn = 50;

module smalldot() 
resize([p_x * h_s -d, p_y * h_s - d]) cylinder(p_z, 10, 10);

module bigdot()
resize([p_x * h_s +d, p_y * h_s +d]) cylinder(p_z*3, 10, 10, true);

module piece(){
    difference(){
        translate([d/2, d/2]) cube([p_x -d, p_y -d, p_z]);
        translate([p_x * h_d, p_y * 0.5]) bigdot();
        translate([p_x * 0.5, p_y * h_d]) bigdot();
    }
    translate([p_x * (h_d + 1), p_y * 0.5]) smalldot();
    translate([p_x * 0.5, p_y * (h_d + 1)]) smalldot();   
}

module puzzle() 
for (x= [0 : amount[0]-1], y = [0 : amount[1]-1]) 
    translate([x * p_x, y * p_y]) piece();

puzzle();

color("blue") translate([87, 87]) resize([380, 380]) rotate([0, 0, 180])
import("/Users/Ben/Desktop/Penrose.stl");

