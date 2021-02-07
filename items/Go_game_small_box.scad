dist13 = 10.5;  // distance between stones of 13x13 field
dist9 = dist13 * 1.5;
s = dist13 * 6; // half size
pin = 9;        // vertical space pin needs in box
pin2 = 7;       // actual length of pin
minW = 1.5;     // least wall thickness
height = pin + 3* minW + 1.8;

module shape2d() hull() {
    translate([dist13 - 1.3, 0]) scale([1, 1.7]) circle(4, $fn=25);
    translate([dist13 - 0.3, 0]) square([0.1, height], true);
    };

module shape_round() rotate_extrude($fn=50) shape2d();
    
module basic_shape() hull ()
    for (i=[-s, s], j=[-s, s])
        translate([i, j, 0])shape_round();

module 13er_pins() for(i=[-s: dist13: s], j=[-s: dist13: s])
    translate([i, j, height/2 - pin2/2]) cylinder(pin2, 0.8, 0.8, $fn=15, true);

module 9er_pins() for(i=[-s: dist9: s], j=[-s: dist9: s])
    translate([i, j, -height/2 + pin2/2]) cylinder(pin2, 0.8, 0.8, $fn=15, true);

module 13er_cross() for(i=[-s: dist13: s], j=[-s: dist13: s])
{translate([i, 0, height/2]) rotate([90, 0, 0])
    cylinder(2*s, 0.8, 0.8, $fn=15, true);
translate([0, j, height/2]) rotate([0, 90, 0])
    cylinder(2*s, 0.8, 0.8, $fn=15, true);}

module 9er_cross() for(i=[-s: dist9: s], j=[-s: dist9: s])
{translate([i, 0, -height/2]) rotate([90, 0, 0])
    cylinder(2*s, 0.8, 0.8, $fn=15, true);
translate([0, j, -height/2]) rotate([0, 90, 0])
    cylinder(2*s, 0.8, 0.8, $fn=15, true);}
    
module handle() translate([s, 0, 0])rotate([90, 0, 0])
    intersection(){
        linear_extrude(2, center = true) shape2d();
        cube([3*dist13, pin + minW, pin + minW], true);
    };
    
module drawer() 
    difference(){
        union(){
            translate([2, dist13*-5.5, -pin/2 - minW/2]) 
                cube([dist13*6.5, dist13*11, pin + minW], false);
            handle();
        }
        translate([0, 0, 5]) 
            cube([20, dist13*11 -2*minW, 10], true);
        translate([2 + minW, dist13*-5.5 + minW, -pin/2 + minW/2]) 
            cube([dist13*6.5 -2*minW, dist13*11 -2*minW, pin + minW], false);
    };

// go board
difference(){
    basic_shape();
    13er_pins();
    9er_pins();
    13er_cross();
    9er_cross();
    translate([1.5 + dist13*4, 0, 0]) 
        cube([dist13*8, dist13*11 + 1, pin + minW + 1], true);
    translate([-dist13*4 -1.5, 0, 0]) 
        cube([dist13*8, dist13*11 + 1, pin + minW + 1], true);
};

// drawers, print separately
translate([2.5*s, 0, 0])
    drawer();
translate([2.5*s, 0, 0]) 
    mirror([1, 0, 0]) drawer();

/*
// 13 cross pattern separately
difference(){
    for(i=[-s: dist13: s], j=[-s: dist13: s]){
        translate([0, j, 0]) cube([2*s, 0.5, 0.2], $fn=15, true);
        translate([i, 0, 0]) cube([0.5, 120, 0.2], $fn=15, true);
    };
    for(i=[-s: dist13: s], j=[-s: dist13: s])
    translate([i, j, 0]) cube(2, true);
};

// 9 cross pattern separately
difference(){
    for(i=[-s: dist9: s], j=[-s: dist9: s]){
        translate([0, j, 0]) cube([2*s, 0.5, 0.2], $fn=15, true);
        translate([i, 0, 0]) cube([0.5, 120, 0.2], $fn=15, true);
    };
    for(i=[-s: dist9: s], j=[-s: dist9: s])
    translate([i, j, 0]) cube(2, true);
};
*/