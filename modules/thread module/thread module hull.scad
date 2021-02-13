/*
// You'll need those variables: 
fch = 5;        // full circle height
degrees = 500;
fn = 80;

// ... and some sort of thread_shape (3-dimensional but flat)
thread_polygon = 
    [[10,-1], 
    [8,0], 
    [10,1]];

thread_ang = atan(fch/20);   // divided by twice the diameter

module thread_shape()                       // use what ever shape suits you
    rotate([90 + thread_ang, 0, 0]) linear_extrude(0.1, center = true) 
        polygon(points=thread_polygon);
*/

// ... and this is the actual module to use:
module thread()
    for (i = [0 : 360/fn : degrees-1])
        hull(){
            rotate([0, 0, i]) 
                translate([0,0, fch * i/360])thread_shape();
            rotate([0, 0, i + 360/fn]) 
                translate([0,0, fch * (i/360 + 1/fn)])thread_shape();
            };
            
// thread();
 