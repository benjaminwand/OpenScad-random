p_x = 19;   // side length of puzzle piece
p_y = 19;   // side length of puzzle piece
p_z = 2;    // height of puzzle piece
d = 0.3;    // distance between puzzle pieces
h_s = 0.35;  // knob size
h_d = 0.13;  // knob distance
amount = [10, 10]; // how many pieces one wants
$fn = 50;

module smalldot() 
resize([p_x * h_s -d, p_y * h_s - d]) cylinder(p_z, 10, 10);

module bigdot()
resize([p_x * h_s +d, p_y * h_s +d]) cylinder(p_z*3, 10, 10, true);

module puzzle() 
for (x= [0 : amount[0]-1], y = [0 : amount[1]-1]) translate([x * p_x, y * p_y]) {
    difference(){
        union(){
            cube([p_x -d, p_y -d, p_z]); 
            // The following enumeration can be used 
            // when the pieces shall get shuffeled later
            //color("blue") linear_extrude(p_z * 3) text(str(x*10 + y));
        };
        if(x>-1 && y>0) translate([p_x * 0.5, p_y * h_d]) bigdot();
        if(x>0 && y>-1) translate([p_x * h_d, p_y * 0.5]) bigdot();
    };
    if(x<amount[0]-1) translate([p_x * (h_d + 1), p_y * 0.5]) smalldot();
    if(y<amount[1]-1) translate([p_x * 0.5, p_y * (h_d + 1)]) smalldot();  
}
        
puzzle();
