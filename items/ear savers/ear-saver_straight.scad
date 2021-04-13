// variables
w1 = 5;     // width
h1 = 2;     // height
h2 = 1;
width = 120;

one_arm();
rotate([0, 0, 180])one_arm();
translate([0, 0, h2/2])cube([width, 10, h2], true);

module one_arm() 
    {translate([width/2-20, 0, 0]) rotate([0, 0, -45])
        circle_ish(20, 90, 20);
    translate([width/2-20 + 15/sqrt(2), 15/sqrt(2), 0]) rotate([0, 0, 45])
        circle_ish(5, 90, 20);
    translate([width/2-20 + 15/sqrt(2), -15/sqrt(2), 0]) rotate([0, 0, -45])
        circle_ish(5, -90, 20);}

module circle_ish(r, angle, fn) 
 let (interval = angle/fn)
    for (i= [0:interval:(angle-interval)]) 
        hull(){
            translate([cos(i)*r, sin(i)*r, 0]) shape(); 
            translate([cos(i+interval)*r, sin(i+interval)*r, 0]) shape(); 
        };
        
module shape() hull(){
    rotate_extrude($fn=30) translate([w1/2 - h1/2, h1/2, 0]) 
        circle(d=h1, $fn = 25);
    };
