include <M3.scad>

thickness = 2.15;
distance = 14.22;

x = 26.16;
y = 10;

difference(){
    hull(){
    translate ([x/2, y/2, 0])
        rotate_extrude(convexity = 10, $fn = 50)
            translate([distance * 0.5, 0, 0])
                circle(r = thickness * 2, $fn = 30);
    translate ([-x/2, -y/2, 0])
        rotate_extrude(convexity = 10, $fn = 50)
            translate([distance * 0.5, 0, 0])
                circle(r = thickness * 2, $fn = 30);
    }
    union(){
        for (i = [-distance* 1.5, -distance/2, distance/2, distance* 1.5])
            translate ([i, 0, 0]) 
                hull(){
                    rotate ([90, 0, 0])
                    cylinder (distance*3, thickness/2, thickness/2, true, $fn = 20);
                    translate([0, 0, -thickness * 2])rotate ([90, 0, 0])
                    cylinder (distance*4, thickness/2, thickness/2, true, $fn = 20);
                }
        translate ([0, 0, -distance -thickness/2]) cylinder (distance*2, distance*5, distance*5, true);   
        translate ([x/2, y/2, 0])
            translate([0, 0, thickness/2])rotate ([0, 0, 30])M3_spacer();      
        translate ([-x/2, -y/2, 0])
            translate([0, 0, thickness/2])rotate ([0, 0, 30])M3_spacer();  
    }
}

