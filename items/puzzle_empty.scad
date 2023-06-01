p_x = 19;   // side length of puzzle piece
p_y = 19;   // side length of puzzle piece
p_z = 2;    // height of puzzle piece
d = 0.3;    // distance between puzzle pieces
h_s = 0.35;  // handle sizes
h_d = 0.12;  // handle distance
amount = [10, 10]; // how many pieces one wants
$fn = 50;


module piece(){
difference(){
    translate([d/2, d/2]) cube([p_x -d, p_y -d, p_z]);
    translate([p_x * h_d, p_y * 0.5]) resize([p_x * h_s +d, p_y * h_s +d]) 
        cylinder(p_z*3, 10, 10, true);
    translate([p_x * 0.5, p_y * h_d]) resize([p_x * h_s +d, p_y * h_s +d]) 
        cylinder(p_z*3, 10, 10, true);
}
    translate([p_x * (h_d + 1), p_y * 0.5, p_z/2]) 
        resize([p_x * h_s -d, p_y * h_s - d]) cylinder(p_z, 10, 10, true);
    translate([p_x * 0.5, p_y * (h_d + 1), p_z/2]) 
        resize([p_x * h_s -d, p_y * h_s - d]) cylinder(p_z, 10, 10, true);
    
}

module puzzle() 
for (x= [0 : amount[0]-1], y = [0 : amount[1]-1]) 
    translate([x * p_x, y * p_y]) piece();

puzzle();

