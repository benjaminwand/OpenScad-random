/*
Puzzle with penrose pattern that gets printed unsolved.
*/

p_x = 19;   // side length of puzzle piece
p_y = 19;   // side length of puzzle piece
p_z = 2.4;    // height of puzzle piece
d = 0.3;    // distance between puzzle pieces
h_s = 0.35;  // knob sizes
h_d = 0.13;  // knob distance
dc = 0.6;       // depth of carving
amount = [10, 10]; // how many pieces one wants
//$fn = 50;
shuffle = [02,49,76,93,79,82,7,50,69,54,81,57,23,92,71,88,17,01,18,77,97,90,89,60,83,04,42,70,86,84,55,62,12,09,99,10,98,45,29,40,37,33,38,28,68,95,78,58,75,15,53,87,06,48,64,32,34,74,66,63,31,41,00,14,35,46,11,27,91,30,85,03,26,52,13,08,72,21,73,25,20,39,16,19,61,96,56,43,05,67,44,36,47,59,65,24,22,80,51,94];

module smalldot() 
resize([p_x * h_s - d, p_y * h_s - d]) cylinder(p_z, 10, 10);

module bigdot()
resize([p_x * h_s + d, p_y * h_s + d]) cylinder(p_z * 3, 10, 10, true);

module piece(){
    difference(){
        translate([d/2, d/2]) cube([p_x - d, p_y - d, p_z]);
        translate([p_x * h_d, p_y * 0.5]) bigdot();
        translate([p_x * 0.5, p_y * h_d]) bigdot();
    }
    translate([p_x * (h_d + 1), p_y * 0.5]) smalldot();
    translate([p_x * 0.5, p_y * (h_d + 1)]) smalldot();   
}

module penrose_tiles()
translate([87, 87, p_z -dc]) resize([380, 380]) rotate([0, 0, 180])
    import("Penrose.stl");
    // from https://www.printables.com/de/model/99841-penrose-scadvent-no-21

module puzzle() 
for (x= [0 : amount[0]-1], y = [0 : amount[1]-1]) 
    translate(          // shuffel around
        [shuffle[x * 10 + y]%10 * p_x, 
        floor(shuffle[x * 10 + y]/10) * p_y])                   
translate([-x * p_x, -y * p_y])     // bring back to 0/0
difference(){
    translate([x * p_x, y * p_y]) piece(); 
    penrose_tiles();
}

puzzle();
