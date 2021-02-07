// variables, to be changed
dist13 = 10.5;      // distance between stones of 13x13 field
pin = 9;            // vertical space pin needs in box
minW = 1.5;         // least wall thickness

// calculated proportions, don't touch
s = dist13 * 6;     // half size for pattern
s2 = dist13 * 6.5;  // half board size
dist9 = dist13 * 1.5;   // distance between stones of 9x9 field
drawer_height = pin + minW;
height = drawer_height + 6; 
drawer_width = 11 * dist13 - 5;

module base() hull () for (i=[-s2, s2], j=[-s2, s2])
    translate([i, j, 0])cylinder(2.5, 2, 2, false, $fn=20);

module 13er_pins() for(i=[-s: dist13: s], j=[-s: dist13: s])
    translate([i, j, 0]) cylinder(10, 0.8, 0.8, $fn=15, true);

module 9er_pins() for(i=[-s: dist9: s], j=[-s: dist9: s])
    translate([i, j, 0]) cylinder(10, 0.8, 0.8, $fn=15, true);

module 13er_cross() for(i=[-s: dist13: s], j=[-s: dist13: s])
{translate([i, 0, 0]) rotate([90, 0, 0])
    cylinder(2*s, 0.8, 0.8, $fn=15, true);
translate([0, j, 0]) rotate([0, 90, 0])
    cylinder(2*s, 0.8, 0.8, $fn=15, true);}

module 9er_cross() for(i=[-s: dist9: s], j=[-s: dist9: s])
{translate([i, 0, 0]) rotate([90, 0, 0])
    cylinder(2*s, 0.8, 0.8, $fn=15, true);
translate([0, j, 0]) rotate([0, 90, 0])
    cylinder(2*s, 0.8, 0.8, $fn=15, true);}

module 1_connector()
    {cylinder(height-2.5, 2, 2, false, $fn=20);
    translate([0, 0, height-2.5]) cylinder(2, 2, 0, false, $fn=20);}

module connecters()
    {for (i=[-s2 +dist13 : dist13: s2 -dist13], j=[-s2 + dist13, s2 - dist13])
        translate([i, j, 0]) 1_connector();
    for (j=[-3.5*dist13, -2.5*dist13, -0.5*dist13, 
        0.5*dist13, 2.5*dist13, 3.5*dist13])
        translate([0, j, 0]) 1_connector();
    } 
        
module 1_hole()
    translate([0, 0, 0.51]) cylinder(2, 0, 2, false, $fn=20);

module holes()
    {for (i=[-s2 +dist13 : dist13: s2 -dist13], j=[-s2 + dist13, s2 - dist13])
        translate([i, j, 0]) 1_hole();
    for (j=[-3.5*dist13, -2.5*dist13, -0.5*dist13, 
        0.5*dist13, 2.5*dist13, 3.5*dist13])
        translate([0, j, 0]) 1_hole();
    } 
        
module shape2d() hull() {
    translate([dist13 - 1.3, 0]) scale([1, 1.7]) circle(4, $fn=25);
    translate([dist13 - 0.3, 0]) square([0.1, height], true);
    };
    
module handle() translate([dist13 * 5.5, 0, drawer_height/2+3])rotate([90, 0, 0])
    intersection(){
        linear_extrude(2, center = true) shape2d();
        cube([3*dist13, pin + minW, pin + minW], true);
    };
    
module drawer() 
    difference(){
        union(){
            translate([2.5, drawer_width / -2, 3]) 
                cube([dist13*6, drawer_width, drawer_height], false);
            handle();
        }
        translate([0, 0, drawer_height +3]) 
            cube([20, drawer_width -2*minW, 10], true);
        translate([2.5 + minW, drawer_width/-2 + minW, 3+ minW]) 
            cube([dist13*6 -2*minW, drawer_width -2*minW, drawer_height], false);
    };


// print each of the following parts separately
 
// 13 side of board
difference(){
    union() {
        base();
        connecters();
    }
    13er_pins();
  //  13er_cross();
};

// 9 side of board
translate([-2.5*s, 0, 0]) 
    difference(){
        base();    
        holes();
        9er_pins();
       // 9er_cross();
    };

// drawers
translate([2.5*s, 0, 0])
    drawer();
translate([2.5*s, 0, 0]) 
    mirror([1, 0, 0]) drawer();

// 13 cross pattern (if needed)
translate([0, 2.5*s, 0]) difference(){
    for(i=[-s: dist13: s], j=[-s: dist13: s]){
        translate([0, j, 0]) cube([2*s, 0.5, 0.2], $fn=15, true);
        translate([i, 0, 0]) cube([0.5, 2*s, 0.2], $fn=15, true);
    };
    for(i=[-s: dist13: s], j=[-s: dist13: s])
    translate([i, j, 0]) cube(2, true);
};

// 9 cross pattern (if needed)
translate([-2.5*s, 2.5*s, 0]) difference(){
    for(i=[-s: dist9: s], j=[-s: dist9: s]){
        translate([0, j, 0]) cube([2*s, 0.5, 0.2], $fn=15, true);
        translate([i, 0, 0]) cube([0.5, 2*s, 0.2], $fn=15, true);
    };
    for(i=[-s: dist9: s], j=[-s: dist9: s])
    translate([i, j, 0]) cube(2, true);
};
