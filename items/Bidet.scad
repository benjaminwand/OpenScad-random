// variables

// thread / bottle
full_circle_height = 2.5; 
degrees = 720;

cap_inner_diameter = 28;
thread_inner_diameter = 25.6;
bottle_inner_diameter = 21;
thread_polygon = 
    [[cap_inner_diameter/2,-1], 
    [thread_inner_diameter/2,0], 
    [cap_inner_diameter/2,1]];

// file / printer
min_wall = 0.8;         // least wall thickness
fn = 80;

// other
water_diameter = 7.5;
holes = 1.8;

// proportions, don't touch
fs = 360/fn;
thread_ang = atan(full_circle_height/(cap_inner_diameter*2));

// actual file
difference(){
    union(){        // plus
        cylinder(12 + min_wall, 
            cap_inner_diameter/2 + min_wall, 
            cap_inner_diameter/2 + min_wall, false, $fn = fn);
        translate([0, 0, 12.5])
            cylinder (27.5, cap_inner_diameter/2 + min_wall, 
            water_diameter/2 + min_wall, false, $fn = fn);
        rotate([0, 0, 180])translate([-20, 0, 40])
            rotate([90, 0, 0])
                rotate_extrude(angle =  135, $fn = fn)
                    translate([20, 0])
                        circle(water_diameter/2 + min_wall, $fn = fn/2);
        translate([14, 1.5, 13])
            rotate([0, -45, 0]) rotate([90, 0, 0])
                    cube([40, 13, 3]);
        translate([34.1, 0, 54.1])
            rotate([0,135, 0])
                cylinder(15, water_diameter/2 + min_wall, 
                    water_diameter/2 + min_wall, $fn = fn/2);
    }
    union(){       // minus
        translate([0, 0,-0.1])cylinder(10.1, cap_inner_diameter/2, cap_inner_diameter/2, false, $fn = fn);
        translate([0, 0, 9.99])cylinder(2 + min_wall, cap_inner_diameter/2, bottle_inner_diameter/2, false, $fn = fn);
    translate([0, 0, 12])
        cylinder (28.01, bottle_inner_diameter/2, water_diameter/2, false, $fn = fn);
    rotate([0, 0, 180])translate([-20, 0, 40])
        rotate([90, 0, 0])
            rotate_extrude(angle =  135, $fn = fn)
                translate([20, 0])circle(water_diameter/2, $fn = fn/2);
    translate([39, 0, 40.5])
        rotate([0, 135, 0]) rotate([-90, 0, 0])
            linear_extrude(5, center = true)
                text("Bidet", font= "Blackout:style=Midnight", size= 9, spacing = 1.1);
    translate([34.1, 0, 54.101])
        rotate([0, 135, 0])
            translate ([0, 0, -10])
                {cylinder(30, holes/2, holes/2, false, $fn = 6);
                for (i = [0:60:360])
                    rotate([6, 0, i])
                        cylinder(30, holes/2, holes/2, false, $fn = 6);};
    };
};

// thread
difference(){       
    for (i = [0 : fs : degrees-1])
    hull(){
        rotate([0, 0, i-90]) 
            translate([0,0, 2 + full_circle_height * i/360])thread_shape();
        rotate([0, 0, i+fs-90]) 
            translate([0,0, 2 + full_circle_height * (i+fs)/360])thread_shape();
        };
    union() 
    {translate([0,0, 2]) cutoff_shape();
    rotate([0, 0, degrees]) 
        translate([0,0, 2 + full_circle_height * degrees/360]) 
            rotate([0,180, 0])cutoff_shape();};
};

// modules
module cutoff_shape() 
    {linear_extrude(2, center = true) polygon(points= 
        [[thread_inner_diameter/4, -thread_inner_diameter/4],
        [-thread_inner_diameter/4, -thread_inner_diameter/4],
        [-thread_inner_diameter/4, -cap_inner_diameter/2],
        [0, -cap_inner_diameter/2]]);}

module thread_shape()
    rotate([90 + thread_ang, 0, 0]) linear_extrude(0.1, center = true) polygon(points=thread_polygon);